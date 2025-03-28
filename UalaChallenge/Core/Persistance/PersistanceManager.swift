//
//  PersistanceManager.swift
//  UalaChallenge
//
//  Created by NaranjaX on 28/03/2025.
//

import Foundation

protocol PersistanceProviderProtocol: PersistanceListProviderProtocol  {
}

final class PersistanceManager {
    let repository: UserDefaults
    
    init(repository: UserDefaults) {
        self.repository = repository
    }
}

extension PersistanceManager: PersistanceProviderProtocol {
    func set(value: [String], forKey defaultName: PersistanceListKeys) {
        let uniqueValues = Array(Set(value))
        
        repository.set(uniqueValues, forKey: defaultName.rawValue)
    }
    
    func list(forKey defaultName: PersistanceListKeys) -> [String]? {
        repository.stringArray(forKey: defaultName.rawValue)
    }
}

