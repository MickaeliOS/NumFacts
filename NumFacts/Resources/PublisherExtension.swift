//
//  PublisherExtension.swift
//  NumFacts
//
//  Created by Mickaël Horn on 01/02/2024.
//

import Foundation
import Combine

extension Publisher {
    func asResult() -> AnyPublisher<Result<Output, Failure>, Never> {
        self
            // If the Publisher have no error, we transform his Output to .success
            .map(Result.success)

            // In case we have an error, we transform it into a .failure
            .catch { error in
                Just(.failure(error))
            }
            .eraseToAnyPublisher()
    }
}
