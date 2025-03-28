//
//  MockPersistanceProvider.swift
//  UalaChallengeTests
//
//  Created by NaranjaX on 28/03/2025.
//

import Foundation
import XCTest

@testable import UalaChallenge

class MockPersistanceProvider: PersistanceProviderProtocol {
    private var storage: [String: [String]] = [:]

    func set(value: [String], forKey defaultName: PersistanceListKeys) {
        storage[defaultName.rawValue] = value
    }

    func list(forKey defaultName: PersistanceListKeys) -> [String]? {
        return storage[defaultName.rawValue]
    }
}
