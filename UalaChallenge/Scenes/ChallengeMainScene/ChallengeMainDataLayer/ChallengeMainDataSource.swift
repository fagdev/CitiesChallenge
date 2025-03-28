//
//  ChallengeMainDataSource.swift
//  UalaChallenge
//
//  Created by NaranjaX on 28/03/2025.
//

import Foundation

protocol ChallengeMainDataSourceProtocol {
    func fetchCities() async -> Result<[ChallengeCitiesDTO], ChallengeNetworkError>
}


final class ChallengeMainDataSource: ChallengeMainDataSourceProtocol {
    private let networkClient: ChallengeNetworkClientProtocol

    init(networkClient: ChallengeNetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func fetchCities() async -> Result<[ChallengeCitiesDTO], ChallengeNetworkError> {
        let url = String.defaultUrl
        return await networkClient.get(from: url)
    }
}

fileprivate extension String {
    static let defaultUrl = "https://gist.githubusercontent.com/hernan-uala/dce8843a8edbe0b0018b32e137bc2b3a/raw/0996accf70cb0ca0e16f9a99e0ee185fafca7af1"
}
