//
//  RepositoryTests.swift
//  UalaChallengeTests
//
//  Created by NaranjaX on 28/03/2025.
//

import Foundation
import XCTest

@testable import UalaChallenge

class RepositoryTests: XCTestCase {
    
    var mockDataSource: DataSourceMock!
    var repository: ChallengeMainRepository!

    override func setUp() {
        super.setUp()
        
        // Configuración del Mock y del Repository
        mockDataSource = DataSourceMock()
        repository = ChallengeMainRepository(remoteDataSource: mockDataSource)
    }

    override func tearDown() {
        mockDataSource = nil
        repository = nil
        super.tearDown()
    }
    
    // Test caso exitoso
    func testGetCitiesSuccess() async {
        let expectedCities = [ChallengeCitiesDTO(
            id: 1111,
            name: "name",
            country: "country",
            coord: ChallengeCitiesCoordinatesDTO(
                lon: 11,
                lat: 12
            )
        )]
        
        mockDataSource.mockResult = .success(expectedCities)
                
        let result = await mockDataSource.fetchCities()
        
        switch result {
        case .success(let cities):
            XCTAssertEqual(cities.count, 1, "Deberían devolverse 2 ciudades.")
            XCTAssertEqual(cities.first?.name, "name", "La primera ciudad debería ser 'City1'.")
            XCTAssertEqual(cities.first?.country, "country", "La primera ciudad debería estar en 'Country1'.")
        case .failure(let error):
            XCTFail("Se esperaba éxito, pero ocurrió un error: \(error)")
        }
    }

    // Test caso fallido
    func testGetCitiesFailure() async {
        mockDataSource.mockResult = .failure(.requestFailed(NSError(domain: "TestError", code: -1, userInfo: nil)))
        
        let result = await repository.getCities()
        
        switch result {
        case .success(_):
            XCTFail("Se esperaba un error, pero la solicitud fue exitosa.")
        case .failure(let error):
            XCTAssertNotNil(error, "Se esperaba un error de red.")
        }
    }
}
