//
//  ChallengeViewModelTests.swift
//  UalaChallengeTests
//
//  Created by NaranjaX on 28/03/2025.
//

import Foundation
import XCTest

@testable import UalaChallenge

@MainActor
class ChallengeMainViewModelTests: XCTestCase {
    
    var mockUseCase: MockUseCase!
    var mockPersistance: MockPersistanceProvider!
    var viewModel: ChallengeMainViewModel!

    override func setUp() {
        super.setUp()
        mockUseCase = MockUseCase()
        mockPersistance = MockPersistanceProvider()
        viewModel = ChallengeMainViewModel(
            citiesUseCase: mockUseCase,
            persistanceProvider: mockPersistance
        )
    }

    override func tearDown() {
        mockUseCase = nil
        mockPersistance = nil
        viewModel = nil
        super.tearDown()
    }

    // Test carga exitosa de ciudades
    func testLoadCitiesSuccess() async {
        let expectedCities = [
            ChallengeCitiesDTO(id: 1, name: "Buenos Aires", country: "Argentina", coord: ChallengeCitiesCoordinatesDTO(lon: 11, lat: 12)),
            ChallengeCitiesDTO(id: 2, name: "Barcelona", country: "España", coord: ChallengeCitiesCoordinatesDTO(lon: 11, lat: 12)),
            ChallengeCitiesDTO(id: 3, name: "Bogotá", country: "Colombia", coord: ChallengeCitiesCoordinatesDTO(lon: 11, lat: 12)),
        ]
        mockUseCase.mockResult = .success(expectedCities)
        
        await viewModel.loadCities()
        
        XCTAssertEqual(viewModel.showingCities?.count, 3, "Debería haber 3 ciudades en showingCities.")
        XCTAssertEqual(viewModel.showingCities?.first?.name, "Buenos Aires", "La primera ciudad debería ser 'Buenos Aires'.")
        XCTAssertNil(viewModel.errorMessage, "No debería haber error en una carga exitosa.")
    }

    // Test carga fallida de ciudades
    func testLoadCitiesFailure() async {
        mockUseCase.mockResult = .failure(.requestFailed(NSError(domain: "TestError", code: -1, userInfo: nil)))
        
        await viewModel.loadCities()
        
        XCTAssertNil(viewModel.showingCities, "showingCities debería ser nil en caso de error.")
        XCTAssertNotNil(viewModel.errorMessage, "Debería haber un mensaje de error.")
    }

    // Test filtrado de ciudades
    func testFilterCities() async {
        let cities = [
            ChallengeCitiesDTO(id: 1, name: "Buenos Aires", country: "Argentina", coord: ChallengeCitiesCoordinatesDTO(lon: 11, lat: 12)),
            ChallengeCitiesDTO(id: 2, name: "Barcelona", country: "España", coord: ChallengeCitiesCoordinatesDTO(lon: 11, lat: 12)),
            ChallengeCitiesDTO(id: 3, name: "Bogotá", country: "Colombia", coord: ChallengeCitiesCoordinatesDTO(lon: 11, lat: 12)),
        ]
        mockUseCase.mockResult = .success(cities)
        await viewModel.loadCities()

        viewModel.filterCities(by: "Bue")
        
        XCTAssertEqual(viewModel.showingCities?.count, 1, "Solo debería haber una ciudad con el prefijo 'Bue'.")
        XCTAssertEqual(viewModel.showingCities?.first?.name, "Buenos Aires", "La ciudad filtrada debería ser 'Buenos Aires'.")
    }

    // Test paginación de ciudades
    func testPageCities() async {
        let cities = (1...25).map { ChallengeCitiesDTO(id: $0, name: "City \($0)", country: "Country", coord: ChallengeCitiesCoordinatesDTO(lon: 11, lat: 11)) }
        mockUseCase.mockResult = .success(cities)
        await viewModel.loadCities()

        viewModel.pageCities() // Segunda página
        
        XCTAssertEqual(viewModel.showingCities?.count, 20, "Después de paginar debería haber 20 ciudades en showingCities.")
    }

    // Test guardado de favoritos
    func testSaveFavoriteCity() {
        let result = viewModel.handlePersistance(with: 1, operation: .save)
        let storedFavorites = mockPersistance.list(forKey: .favoritesIds)

        XCTAssertNil(result, "Guardar un favorito no debería retornar ningún valor.")
        XCTAssertEqual(storedFavorites?.count, 1, "Debería haber un favorito almacenado.")
        XCTAssertEqual(storedFavorites?.first, "1", "El ID almacenado debería ser '1'.")
    }

    // Test leer favorito
    func testReadFavoriteCity() {
        _ = viewModel.handlePersistance(with: 1, operation: .save)
        
        let isFavorite = viewModel.handlePersistance(with: 1, operation: .read)
        
        XCTAssertTrue(isFavorite!, "El ID 1 debería estar en favoritos.")
    }

    // Test eliminar favorito
    func testDeleteFavoriteCity() {
        _ = viewModel.handlePersistance(with: 1, operation: .save)
        _ = viewModel.handlePersistance(with: 1, operation: .delete)
        
        let isFavorite = viewModel.handlePersistance(with: 1, operation: .read)
        
        XCTAssertFalse(isFavorite!, "El ID 1 debería haber sido eliminado de favoritos.")
    }
}
