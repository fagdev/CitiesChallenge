//
//  ChallengeNetworkClient.swift
//  UalaChallenge
//
//  Created by NaranjaX on 28/03/2025.
//

import Foundation

protocol ChallengeNetworkClientProtocol {
    func get<T: Decodable>(from urlString: String) async -> Result<T, ChallengeNetworkError>
}

final class ChallengeNetworkClient: ChallengeNetworkClientProtocol {
    static let shared = ChallengeNetworkClient()
    private init() {}

    func get<T: Decodable>(from urlString: String) async -> Result<T, ChallengeNetworkError> {
        guard let url = URL(string: urlString), url.scheme != nil else {
            return .failure(.invalidURL)
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return .failure(.invalidResponse)
            }

            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        } catch let error as DecodingError {
            return .failure(.decodingFailed(error))
        } catch {
            return .failure(.requestFailed(error))
        }
    }
}
