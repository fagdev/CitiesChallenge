//
//  DataSourceMock.swift
//  UalaChallengeTests
//
//  Created by NaranjaX on 28/03/2025.
//

import Foundation
import XCTest

@testable import UalaChallenge

class DataSourceMock: ChallengeMainDataSourceProtocol {
    var mockResult: Result<[ChallengeCitiesDTO], ChallengeNetworkError>?
    
    func fetchCities() async -> Result<[ChallengeCitiesDTO], ChallengeNetworkError> {
        guard let result = mockResult else {
            return .failure(.invalidResponse)
        }
        return result
    }
}
