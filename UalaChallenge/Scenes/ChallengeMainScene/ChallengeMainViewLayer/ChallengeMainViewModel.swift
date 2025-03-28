//
//  ChallengeMainViewModel.swift
//  UalaChallenge
//
//  Created by NaranjaX on 28/03/2025.
//

import Foundation

enum PersistanceOperation {
    case save
    case read
    case delete
}

protocol ChallengeMainViewModelProtocol: ObservableObject {
    func loadCities() async
    func pageCities()
    func filterCities(by prefix: String)
    func handlePersistance(with id: Int, operation: PersistanceOperation) -> Bool?
    var showingCities: [ChallengeCitiesDTO]? { get }
}

@MainActor final class ChallengeMainViewModel {
    @Published var showingCities: [ChallengeCitiesDTO]?
    var cities: [ChallengeCitiesDTO]?
    var filteredCities: [ChallengeCitiesDTO]?
    private var cityPrefixDict: [String: [ChallengeCitiesDTO]] = [:]
    @Published var errorMessage: String?
    var pagingCount = 0
    
    private let citiesUseCase: ChallengeMainUseCaseProtocol
    private let persistanceProvider: PersistanceProviderProtocol
    
    init(
        citiesUseCase: ChallengeMainUseCaseProtocol,
        persistanceProvider: PersistanceProviderProtocol
    ) {
        self.citiesUseCase = citiesUseCase
        self.persistanceProvider = persistanceProvider
    }
    
    func loadCities() async {
        let result = await citiesUseCase.execute()

        switch result {
        case .success(let cities):
            self.cities = cities
            self.filteredCities = cities
            self.showingCities = Array(cities.prefix(10))
            self.cityPrefixDict = createCityPrefixDictionary(cities)
            self.pagingCount = 1
        case .failure(let error):
            self.errorMessage = "Error: \(error)"
        }
    }
    
    private func createCityPrefixDictionary(_ cities: [ChallengeCitiesDTO]) -> [String: [ChallengeCitiesDTO]] {
        var prefixDict: [String: [ChallengeCitiesDTO]] = [:]

        for city in cities {
            let cityName = city.name.lowercased()
            if cityName.count > 2 {
                for i in 0..<(cityName.count - 2) {
                    let prefix = String(cityName.prefix(i + 1))
                    
                    if prefixDict[prefix] != nil {
                        prefixDict[prefix]?.append(city)
                    } else {
                        prefixDict[prefix] = [city]
                    }
                }
            }
        }

        return prefixDict
    }
    
    func filterCities(by prefix: String) {
        if prefix.isEmpty {
            self.filteredCities = cities
            if let filteredCities = filteredCities {
                showingCities = Array(filteredCities.prefix(10))
                pagingCount = 1
            }
            return
        }
        
        let lowercasedPrefix = prefix.lowercased()

        if let citiesWithPrefix = cityPrefixDict[lowercasedPrefix] {
            self.filteredCities = citiesWithPrefix
        } else {
            self.filteredCities = []
        }
        
        if let filteredCities = filteredCities {
            showingCities = Array(filteredCities.prefix(10))
            pagingCount = 1
        }
    }
    
    func pageCities() {
        guard let filteredCities = filteredCities else { return }

        let startIndex = pagingCount * 10
        let endIndex = min(startIndex + 10, filteredCities.count)

        if startIndex >= filteredCities.count {
            return
        }
        
        let nextCities = Array(filteredCities[startIndex..<endIndex])

        showingCities?.append(contentsOf: nextCities)

        pagingCount += 1
    }
}

extension ChallengeMainViewModel: ChallengeMainViewModelProtocol {
    func handlePersistance(with id: Int, operation: PersistanceOperation) -> Bool? {
        let stringId = String(id)
        var favorites: [String] = []
        if let favoritesStored = persistanceProvider.list(forKey: .favoritesIds) {
            favorites = favoritesStored
        }
        
        switch operation {
        case .save:
            favorites.append(stringId)
            persistanceProvider.set(value: Array(favorites), forKey: .favoritesIds)
            
        case .read:
            return favorites.contains(stringId)
            
        case .delete:
            favorites.removeAll { id in
                id == stringId
            }
            persistanceProvider.set(value: Array(favorites), forKey: .favoritesIds)
        }
        
        return nil
    }
}

