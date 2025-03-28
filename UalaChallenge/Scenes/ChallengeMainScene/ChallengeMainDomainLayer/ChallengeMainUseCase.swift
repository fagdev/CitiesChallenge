//
//  ChallengeMainUseCase.swift
//  UalaChallenge
//
//  Created by NaranjaX on 28/03/2025.
//

import Foundation

protocol ChallengeMainUseCaseProtocol {
    func execute() async -> Result<[ChallengeCitiesDTO], ChallengeNetworkError>
}

final class ChallengeMainUseCase: ChallengeMainUseCaseProtocol {
    private let repository: ChallengeMainRepositoryProtocol

    init(repository: ChallengeMainRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async -> Result<[ChallengeCitiesDTO], ChallengeNetworkError> {
        return await repository.getCities()
    }
}
