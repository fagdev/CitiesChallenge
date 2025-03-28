//
//  ChallengeNetworkErrorEnum.swift
//  UalaChallenge
//
//  Created by NaranjaX on 28/03/2025.
//

import Foundation

enum ChallengeNetworkError: Error, Equatable {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
    
    static func ==(lhs: ChallengeNetworkError, rhs: ChallengeNetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.requestFailed(let lhsError), .requestFailed(let rhsError)):
            guard let lhsNSError = lhsError as? NSError,
                  let rhsNSError = rhsError as? NSError else {
                return false
            }
            return lhsNSError.domain == rhsNSError.domain &&
                   lhsNSError.code == rhsNSError.code
        case (.invalidResponse, .invalidResponse):
            return true
        case (.decodingFailed(let lhsError), .decodingFailed(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

