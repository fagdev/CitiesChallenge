//
//  ChallengeCitiesDTO.swift
//  UalaChallenge
//
//  Created by NaranjaX on 28/03/2025.
//

import Foundation

struct ChallengeCitiesDTO: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let country: String
    let coord: ChallengeCitiesCoordinatesDTO

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case country
        case coord
    }
    
    static func ==(lhs: ChallengeCitiesDTO, rhs: ChallengeCitiesDTO) -> Bool {
        return lhs.id == rhs.id
    }
}

struct ChallengeCitiesCoordinatesDTO: Codable {
    let lon: Double
    let lat: Double
}
