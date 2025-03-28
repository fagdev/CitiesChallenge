//
//  NetworkingTests.swift
//  UalaChallengeTests
//
//  Created by NaranjaX on 28/03/2025.
//

import XCTest
@testable import UalaChallenge

struct Slide: Codable {
    let title: String
    let type: String
    let items: [String]?
}

struct Slideshow: Codable {
    let author: String
    let date: String
    let slides: [Slide]
    let title: String
}

struct JsonResponse: Codable {
    let slideshow: Slideshow
}

class ChallengeNetworkClientTests: XCTestCase {
    
    var networkClient: ChallengeNetworkClientProtocol!
    
    override func setUp() {
        super.setUp()
        networkClient = ChallengeNetworkClient.shared
    }
    
    override func tearDown() {
        networkClient = nil
        super.tearDown()
    }
    
    func testInvalidURL() async {
        let result: Result<Data, ChallengeNetworkError> = await networkClient.get(from: "no valid url")
        
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .invalidURL, "Se esperaba el error invalidURL.")
        default:
            XCTFail("Se esperaba un error de URL inválida.")
        }
    }
    
    func testInvalidResponse() async {
        let result: Result<Data, ChallengeNetworkError> = await networkClient.get(from: "https://httpbin.org/status/404")
        
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .invalidResponse, "Se esperaba el error invalidResponse.")
        default:
            XCTFail("Se esperaba un error de respuesta inválida.")
        }
    }
    
    func testDecodingFailed() async {
        let result: Result<Data, ChallengeNetworkError> = await networkClient.get(from: "https://httpbin.org/json")
        
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .decodingFailed(DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Error", underlyingError: nil))), "Se esperaba el error decodingFailed.")
        default:
            XCTFail("Se esperaba un error de decodificación.")
        }
    }
    
    func testSuccessfulRequest() async {
        let result: Result<JsonResponse, ChallengeNetworkError> = await networkClient.get(from: "https://httpbin.org/json")
        
        switch result {
        case .success(let data):
            XCTAssertEqual(data.slideshow.title, "Sample Slide Show", "Se esperaba el valor 'Sample Slide Show' para el título.")
            XCTAssertEqual(data.slideshow.slides.count, 2, "Se esperaban 2 slides.")
            XCTAssertEqual(data.slideshow.slides.first?.title, "Wake up to WonderWidgets!", "Se esperaba el título 'Wake up to WonderWidgets!' para el primer slide.")
        case .failure(let error):
            XCTFail("Se esperaba éxito, pero se obtuvo error: \(error)")
        }
    }
}
