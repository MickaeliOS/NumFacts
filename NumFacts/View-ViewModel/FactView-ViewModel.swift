//
//  FactView-ViewModel.swift
//  NumFacts
//
//  Created by Mickaël Horn on 18/01/2024.
//

import Foundation
import Combine

extension FactView {
    class ViewModel: ObservableObject {
        // MARK: - PROPERTIES
        @Published var number: String = ""
        @Published var fact: Fact?
        @Published var errorMessage: String?

        lazy var numberPublisher: AnyPublisher<Result<Fact, APIService.APIServiceError>, Never> = {
            $number
                .map { [weak self] number in
                    if number.isReallyEmpty {
                        self?.fact = nil
                    }

                    return number
                }
                .debounce(for: 0.4, scheduler: DispatchQueue.main)
                .filter({ !$0.isReallyEmpty })
                .flatMap { number in
                    return self.apiService.fetchFact(for: number)
                        .asResult()
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }()

        private let apiService: APIService

        // MARK: - INIT
        init(apiService: APIService = APIService(session: URLSession(configuration: .default))) {
            self.apiService = apiService

            numberPublisher
                .map { result -> Fact? in
                    switch result {
                    case .failure:
                        return nil

                    case .success(let fact):
                        return fact
                    }
                }
                .assign(to: &$fact)

            numberPublisher
                .map { result in
                    switch result {
                    case .failure(let error):
                        return error.errorDescription

                    case .success:
                        return nil
                    }
                }
                .assign(to: &$errorMessage)
        }
    }
}
