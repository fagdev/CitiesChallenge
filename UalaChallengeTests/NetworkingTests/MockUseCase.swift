//
//  MockUseCase.swift
//  UalaChallengeTests
//
//  Created by NaranjaX on 28/03/2025.
//

import Foundation
import XCTest

@testable import UalaChallenge

class MockUseCase: ChallengeMainUseCaseProtocol {
    var mockResult: Result<[ChallengeCitiesDTO], ChallengeNetworkError>?
    
    func execute() async -> Result<[ChallengeCitiesDTO], ChallengeNetworkError> {
        return mockResult ?? .failure(.invalidResponse)
    }
}
