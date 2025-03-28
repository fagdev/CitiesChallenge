//
//  UalaChallengeApp.swift
//  UalaChallenge
//
//  Created by NaranjaX on 28/03/2025.
//

import SwiftUI

@main
struct UalaChallengeApp: App {
    let dependenciesResolver = ChallengeDependenciesResolver.shared
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ChallengeMainView(viewModel: ChallengeMainViewModel(citiesUseCase: dependenciesResolver.resolveMainUseCase(), 
                                                                    persistanceProvider: dependenciesResolver.resolvePersistanceProvider()))
            }
        }
    }
}
