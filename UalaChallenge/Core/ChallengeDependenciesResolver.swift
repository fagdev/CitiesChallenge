//
//  ChallengeDependenciesResolver.swift
//  UalaChallenge
//
//  Created by NaranjaX on 28/03/2025.
//

import Foundation

protocol ChallengeDependenciesResolverProtocol {
    func resolveMainUseCase() -> ChallengeMainUseCaseProtocol
    func resolvePersistanceProvider() -> PersistanceProviderProtocol
}

final class ChallengeDependenciesResolver { 
    static let shared: ChallengeDependenciesResolverProtocol = ChallengeDependenciesResolver()
    
    private lazy var dependencies: ChallengeCoreDependencies = {
        return ChallengeCoreDependencies(
            networking: resolveNetworkClient(),
            userDefaultsRepository: .standard
        )
    }()
}

extension ChallengeDependenciesResolver: ChallengeDependenciesResolverProtocol {
    func resolvePersistanceProvider() -> PersistanceProviderProtocol {
        PersistanceManager(repository: dependencies.userDefaultsRepository)
    }
    
    func resolveMainUseCase() -> ChallengeMainUseCaseProtocol {
        ChallengeMainUseCase(repository: resolveMainRepository())
    }
}

private extension ChallengeDependenciesResolver {
    func resolveMainRepository() -> ChallengeMainRepositoryProtocol {
        ChallengeMainRepository(remoteDataSource: resolveMainDataSource())
    }
    
    func resolveMainDataSource() -> ChallengeMainDataSourceProtocol {
        ChallengeMainDataSource(networkClient: resolveNetworkClient())
    }
    
    func resolveNetworkClient() -> ChallengeNetworkClientProtocol {
        ChallengeNetworkClient.shared
    }
}

