//
//  DataResponse.swift
//  NumFactsTests
//
//  Created by Mickaël Horn on 05/03/2024.
//

import Foundation

class DataResponse {
    static var mockData: Data = {
        let bundle = Bundle(for: DataResponse.self)

        guard let url = bundle.url(forResource: "fact", withExtension: "json") else {
            fatalError("Failed to locate fact.json in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load fact.json from bundle.")
        }

        return data
    }()

    static let incorrectData = "error".data(using: .utf8)!

    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://mockurl.com")!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil
    )!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://mockurl.com")!,
        statusCode: 500,
        httpVersion: nil,
        headerFields: nil
    )!
}
