//
//  MovieAppTests.swift
//  MovieAppTests
//
//  Created by Emre on 31.12.2021.
//

import XCTest
@testable import MovieApp

class MovieAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetMovies() throws {
        let expectation = expectation(description: "Service Call")

        NetworkManager.shared.movies(page: 1) { result in
            switch result {
            case .success(let response):
                if response.results != nil {
                    XCTAssert(true)
                } else {
                    XCTFail("No source found!", file: #filePath, line: #line)
                }
            case .failure(let error):
                XCTFail(error.localizedDescription, file: #filePath, line: #line)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

}
