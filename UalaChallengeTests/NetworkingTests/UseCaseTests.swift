//
//  UseCaseTests.swift
//  UalaChallengeTests
//
//  Created by NaranjaX on 28/03/2025.
//

import Foundation
import XCTest

@testable import UalaChallenge

class ChallengeMainUseCaseTests: XCTestCase {
    
    var mockRepository: MockMainRepository!
    var useCase: ChallengeMainUseCase!

    override func setUp() {
        super.setUp()
        
        mockRepository = MockMainRepository()
        useCase = ChallengeMainUseCase(repository: mockRepository)
    }

    override func tearDown() {
        mockRepository = nil
        useCase = nil
        super.tearDown()
    }
    
    func testExecuteSuccess() async {
        let expectedCities = [ChallengeCitiesDTO(
            id: 1111,
            name: "name",
            country: "country",
            coord: ChallengeCitiesCoordinatesDTO(
                lon: 11,
                lat: 12
            )
        )]
        
        mockRepository.mockResult = .success(expectedCities)
                
        let result = await mockRepository.getCities()
        
        switch result {
        case .success(let cities):
            XCTAssertEqual(cities.count, 1, "Deberían devolverse 2 ciudades.")
            XCTAssertEqual(cities.first?.name, "name", "La primera ciudad debería ser 'City1'.")
            XCTAssertEqual(cities.first?.country, "country", "La primera ciudad debería estar en 'Country1'.")
        case .failure(let error):
            XCTFail("Se esperaba éxito, pero ocurrió un error: \(error)")
        }
    }

    func testExecuteFailure() async {
        mockRepository.mockResult = .failure(.requestFailed(NSError(domain: "TestError", code: -1, userInfo: nil)))
        
        let result = await useCase.execute()
        
        switch result {
        case .success(_):
            XCTFail("Se esperaba un error, pero la solicitud fue exitosa.")
        case .failure(let error):
            XCTAssertNotNil(error, "Se esperaba un error de red.")
        }
    }
}
