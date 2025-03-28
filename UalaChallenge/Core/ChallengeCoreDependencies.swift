//
//  ChallengeCoreDependencies.swift
//  UalaChallenge
//
//  Created by NaranjaX on 28/03/2025.
//

import Foundation

protocol ChallengeCoreDependenciesProtocol {
    var networking: ChallengeNetworkClientProtocol { get }
    var userDefaultsRepository: UserDefaults { get }
}

final class ChallengeCoreDependencies: ChallengeCoreDependenciesProtocol {
    var networking: ChallengeNetworkClientProtocol
    var userDefaultsRepository: UserDefaults
    
    init(
        networking: ChallengeNetworkClientProtocol,
        userDefaultsRepository: UserDefaults
    ) {
        self.networking = networking
        self.userDefaultsRepository = userDefaultsRepository
    }
}

