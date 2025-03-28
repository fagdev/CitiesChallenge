//
//  DataSourceTests.swift
//  UalaChallengeTests
//
//  Created by NaranjaX on 28/03/2025.
//

import XCTest
@testable import UalaChallenge

struct ChallengeCitiesModelMockDTO: Codable {
    let name: String
    let country: String
}

class ChallengeMainDataSourceTests: XCTestCase {
    
    var mockNetworkClient: MockChallengeNetworkClient!
    var dataSource: ChallengeMainDataSource!

    override func setUp() {
        super.setUp()
        
        mockNetworkClient = MockChallengeNetworkClient()
        dataSource = ChallengeMainDataSource(networkClient: mockNetworkClient)
    }

    override func tearDown() {
        mockNetworkClient = nil
        dataSource = nil
        super.tearDown()
    }
    
    func testFetchCitiesSuccess() async {
        let expectedCities = [ChallengeCitiesDTO(
            id: 1111,
            name: "name",
            country: "country",
            coord: ChallengeCitiesCoordinatesDTO(
                lon: 11,
                lat: 12
            )
        )]
        
        mockNetworkClient.mockResult = .success(expectedCities)
                
        let result = await dataSource.fetchCities()
        
        switch result {
        case .success(let cities):
            XCTAssertEqual(cities.count, 1, "Deberían devolverse 2 ciudades.")
            XCTAssertEqual(cities.first?.name, "name", "La primera ciudad debería ser 'City1'.")
            XCTAssertEqual(cities.first?.country, "country", "La primera ciudad debería estar en 'Country1'.")
        case .failure(let error):
            XCTFail("Se esperaba éxito, pero ocurrió un error: \(error)")
        }
    }

    func testFetchCitiesFailure() async {
        mockNetworkClient.mockResult = .failure(.invalidURL)
        
        let result = await dataSource.fetchCities()
        
        switch result {
        case .success(_):
            XCTFail("Se esperaba un error, pero la solicitud fue exitosa.")
        case .failure(let error):
            XCTAssertEqual(error, .invalidURL, "Se esperaba el error 'invalidURL'.")
        }
    }
}

