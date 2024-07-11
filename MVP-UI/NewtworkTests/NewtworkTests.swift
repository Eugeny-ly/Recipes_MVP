// NewtworkTests.swift
// Copyright © RoadMap. All rights reserved.

import XCTest

final class NetworkServiceTest: XCTestCase {
    var networkService: NetworkServiceProtocol?

    override func setUpWithError() throws {
        networkService = NetworkService()
    }

    override func tearDownWithError() throws {
        networkService = nil
    }

    func testGetRecipe() throws {
        let expectation = XCTestExpectation(description: "Get Recipe")

        networkService?.getRecipe(type: .chicken) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(recipes):
                    expectation.fulfill()
                case let .failure(error):
                    XCTFail(error.localizedDescription)
                    expectation.fulfill()
                }
            }
        }

        wait(for: [expectation], timeout: 5)
    }

    func testGetDetail() throws {
        let expectation = XCTestExpectation(description: "Get Detail")
        let testUri = "http://www.edamam.com/ontologies/edamam.owl#recipe_45437724af9a4173b237a61a6a4064f2"

        networkService?.getDetail(uri: testUri) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(recipe):
                    expectation.fulfill()
                case let .failure(error):
                    XCTFail(error.localizedDescription)
                    expectation.fulfill()
                }
            }
        }

        wait(for: [expectation])
    }
}
