//
//  PersistanceProviderTests.swift
//  UalaChallengeTests
//
//  Created by NaranjaX on 28/03/2025.
//

import XCTest
@testable import UalaChallenge

class PersistanceProviderTests: XCTestCase {
    
    var persistanceManager: PersistanceManager!
    var mockUserDefaults: MockUserDefaults!
    
    override func setUp() {
        super.setUp()
        mockUserDefaults = MockUserDefaults()
        persistanceManager = PersistanceManager(repository: mockUserDefaults)
    }
    
    override func tearDown() {
        mockUserDefaults.clear()
        persistanceManager = nil
        super.tearDown()
    }
    
    func testSetPersistance() {
        let key: PersistanceListKeys = .favoritesIds
        let values = ["city1", "city2", "city3"]
        
        persistanceManager.set(value: values, forKey: key)
        
        let savedValues = mockUserDefaults.stringArray(forKey: key.rawValue)
        
        XCTAssertEqual(Set(savedValues ?? []), Set(values), "Los valores no coinciden con los que fueron guardados.")
    }
    
    func testListPersistance() {
        let key: PersistanceListKeys = .favoritesIds
        let values = ["city1", "city2", "city3"]
        
        mockUserDefaults.set(values, forKey: key.rawValue)
        
        let retrievedValues = persistanceManager.list(forKey: key)
        
        XCTAssertEqual(retrievedValues, values, "Los valores recuperados no coinciden con los valores guardados.")
    }
    
    func testListPersistanceWhenEmpty() {
        let key: PersistanceListKeys = .favoritesIds
        
        let retrievedValues = persistanceManager.list(forKey: key)
        
        XCTAssertNil(retrievedValues, "Se esperaba que no se encuentren valores guardados.")
    }
    
    func testSetWithDuplicates() {
        let key: PersistanceListKeys = .favoritesIds
        let values = ["city1", "city2", "city1"]
        
        persistanceManager.set(value: values, forKey: key)
        
        let savedValues = mockUserDefaults.stringArray(forKey: key.rawValue)
        let uniqueValues = Array(Set(values))
        XCTAssertEqual(savedValues?.sorted(), uniqueValues.sorted(), "Los valores no son únicos como se esperaba.")
    }
}
