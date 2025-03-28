//
//  ChallengeMainView.swift
//  UalaChallenge
//
//  Created by NaranjaX on 28/03/2025.
//

import SwiftUI

struct ChallengeMainView<ViewModel: ChallengeMainViewModelProtocol>: View {
    @State private var orientation = UIDeviceOrientation.portrait
    
    @StateObject var viewModel: ViewModel
    @State private var isLoadingMore = false
    @State private var searchText = ""
    @State private var selectedCity: ChallengeCitiesDTO? = nil
    @State private var currentLon: Double?
    @State private var currentLat: Double?
    @State private var favsChecked: Bool = false
    
    var body: some View {
        getMainView()
            .onRotate { newOrientation in
                orientation = newOrientation
            }
            .onChange(of: searchText, { oldValue, newValue in
                if oldValue != newValue {
                    viewModel.filterCities(by: newValue)
                }
            })
            .task {
                await viewModel.loadCities()
            }
    }
    
    @ViewBuilder
    private func getMainView() -> some View {
        if orientation.isLandscape {
            HStack {
                getListView()
                ChallengeMapView(lat: $currentLat, lon: $currentLon)
            }
        } else {
            getListView()
        }
    }
    
    @ViewBuilder
    private func getListView() -> some View {
        VStack {
            Text("Available cities")
            
            ChallengeSearchBox(search: $searchText, enabled: true)
                .padding(.horizontal, 16)
            
            HStack() {
                Spacer()
                
                Text(favsChecked ? "Favs Filtering" : "No favs filtering")
                    .font(.footnote)
                    .padding(.leading,16)
                
                Toggle("", isOn: $favsChecked)
                    .toggleStyle(.switch)
                    .padding(.horizontal, 16)
            }
            


            if let cities = viewModel.showingCities {
                ScrollView {
                    LazyVStack {
                        ForEach(cities) { city in
                            let favStatus = viewModel.handlePersistance(with: city.id, operation: .read)
                            
                            if favsChecked {
                                if favStatus ?? false {
                                    getCell(city: city)
                                        .onAppear {
                                            if city == cities[safe: (cities.count - 3)], !isLoadingMore {
                                                loadMoreCities()
                                            }
                                        }
                                    Divider()
                                }
                            } else {
                                getCell(city: city)
                                .onAppear {
                                    if city == cities[safe: (cities.count - 3)], !isLoadingMore {
                                        loadMoreCities()
                                    }
                                }
                                Divider()
                            }
                        }
                    }
                    .padding(16)
                }
            }
        }
    }
    
    @ViewBuilder
    private func getCell(city: ChallengeCitiesDTO) -> some View {
        ChallengeCityCell(
            title: "\(city.name), \(city.country)",
            subtitle: "lat: \(city.coord.lat), lon: \(city.coord.lon)",
            favState: viewModel.handlePersistance(with: city.id, operation: .read) ?? false,
            onTapCell: {
                if orientation.isLandscape {
                    currentLon = city.coord.lon
                    currentLat = city.coord.lat
                } else {
                    navigateToMap(lat: city.coord.lat, lon: city.coord.lon)
                }
            },onTapSecondaryButton: {state in
                if state {
                    viewModel.handlePersistance(with: city.id, operation: .delete)
                } else {
                    viewModel.handlePersistance(with: city.id, operation: .save)
                }
            }
        )
    }
    
    private func loadMoreCities() {
        isLoadingMore = true
        viewModel.pageCities()
        isLoadingMore = false
    }
    
    private func navigateToMap(lat: Double, lon: Double) {
        if let topVC = UIApplication.topViewController() {
            let view = ChallengeMapView(lat: .constant(lat), lon: .constant(lon))
            let hostingController = UIHostingController(rootView: view)
            topVC.present(hostingController, animated: true)
        }
    }
}
