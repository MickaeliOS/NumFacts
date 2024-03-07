//
//  APIService.swift
//  NumFacts
//
//  Created by Mickaël Horn on 18/01/2024.
//

import Foundation
import Combine

final class APIService {
    // MARK: - PROPERTIES
    private var baseStringURL = "http://numbersapi.com"
    private var session: URLSession

    // MARK: - INIT
    init(session: URLSession) {
        self.session = session
    }

    // MARK: - FUNCTIONS
    func fetchFact(for number: String) -> AnyPublisher<Fact, APIServiceError> {
        let completeStringURL = "\(baseStringURL)/\(number)?json"

        guard let url = URL(string: completeStringURL) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }

        return session
            .dataTaskPublisher(for: url)
            .tryMap({ result in
                guard let httpResponse = result.response as? HTTPURLResponse,
                                      httpResponse.statusCode == 200 else {
                    throw APIServiceError.invalidResponse
                }

                guard let fact = try? JSONDecoder().decode(Fact.self, from: result.data) else {
                    throw APIServiceError.decodingError
                }

                return fact
            })
            .receive(on: RunLoop.main)
            .mapError({ error -> APIServiceError in
                if let error = error as? APIServiceError {
                    return error
                }

                return APIServiceError.defaultError
            })
            .eraseToAnyPublisher()
    }
}

// MARK: - EXTENSION
extension APIService {
    enum APIServiceError: Error {
        case invalidURL
        case decodingError
        case invalidResponse
        case defaultError

        var errorDescription: String {
            switch self {
            case .invalidURL:
                "The URL is invalid."
            case .decodingError:
                "An error occured, please enter another number."
            case .invalidResponse:
                "We couldn't get the fact, please select another number."
            case .defaultError:
                "An error occured, please try again."
            }
        }
    }
}
