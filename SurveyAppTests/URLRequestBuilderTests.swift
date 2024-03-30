//
//  URLRequestBuilderTests.swift
//  SurveyAppTests
//
//  Created by Pajaziti Labinot on 30.3.24..
//

import XCTest
@testable import SurveyApp

class MockURLRequestBuilder: URLRequestBuilder {
    var capturedPathComponents: [String] = []
    
    func makeRequest(withPathComponent pathComponent: String) -> URLRequest {
        capturedPathComponents.append(pathComponent)
        return URLRequest(url: URL(string: "https://example.com\(pathComponent)")!)
    }
}

class URLRequestBuilderTests: XCTestCase {

    func testMakeRequestWithPathComponent() throws {
        let builder = MockURLRequestBuilder()
        let expectedPathComponent = "/questions"
        let request = builder.makeRequest(withPathComponent: expectedPathComponent)
        XCTAssertEqual(request.url?.absoluteString, "https://example.com\(expectedPathComponent)")
        XCTAssertEqual(builder.capturedPathComponents, [expectedPathComponent])
    }

}
