//
//  MockNetworkClientProtocol.swift
//  UalaChallengeTests
//
//  Created by NaranjaX on 28/03/2025.
//

import Foundation

@testable import UalaChallenge

class MockChallengeNetworkClient: ChallengeNetworkClientProtocol {
    var mockResult: Result<[ChallengeCitiesDTO], ChallengeNetworkError>?
    
    func get<T: Decodable>(from urlString: String) async -> Result<T, ChallengeNetworkError> {
        
        return mockResult as? Result<T, ChallengeNetworkError> ?? .failure(.invalidResponse)
    }
}
