//
//  ChallengePersistanceListProvider.swift
//  UalaChallenge
//
//  Created by NaranjaX on 28/03/2025.
//

import Foundation

enum PersistanceListKeys: String {
    case favoritesIds
}

protocol PersistanceListSetterListProviderProtocol {
    func set(value: [String], forKey defaultName: PersistanceListKeys)
}

protocol PersistanceListGetterProviderProtocol {
    func list(forKey defaultName: PersistanceListKeys) -> [String]?
}

protocol PersistanceListProviderProtocol: PersistanceListSetterListProviderProtocol, PersistanceListGetterProviderProtocol {
}
