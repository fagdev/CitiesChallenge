//
//  MockUserDefaults.swift
//  UalaChallengeTests
//
//  Created by NaranjaX on 28/03/2025.
//

import Foundation

class MockUserDefaults: UserDefaults {
    private var storage: [String: Any] = [:]
    
    override func set(_ value: Any?, forKey defaultName: String) {
        storage[defaultName] = value
    }
    
    override func stringArray(forKey defaultName: String) -> [String]? {
        return storage[defaultName] as? [String]
    }
    
    func clear() {
        storage.removeAll()
    }
}
