//
//  ChallengeMainRepository.swift
//  UalaChallenge
//
//  Created by NaranjaX on 28/03/2025.
//

import Foundation

protocol ChallengeMainRepositoryProtocol {
    func getCities() async -> Result<[ChallengeCitiesDTO], ChallengeNetworkError>
}

final class ChallengeMainRepository: ChallengeMainRepositoryProtocol {
    private let remoteDataSource: ChallengeMainDataSourceProtocol

    init(remoteDataSource: ChallengeMainDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }

    func getCities() async -> Result<[ChallengeCitiesDTO], ChallengeNetworkError> {
        return await remoteDataSource.fetchCities()
    }
}
