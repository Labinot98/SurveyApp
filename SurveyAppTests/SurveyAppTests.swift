//
//  SurveyAppTests.swift
//  SurveyAppTests
//
//  Created by Pajaziti Labinot on 29.3.24..
//

import XCTest
@testable import SurveyApp

final class SurveyAppTests: XCTestCase {

    func testMakeRequestWithPathComponent() throws {
           let builder = DefaultURLRequestBuilder()
           let expectedURLString = "https://xm-assignment.web.app/questions"
           let request = builder.makeRequest(withPathComponent: "/questions")
           XCTAssertEqual(request.url?.absoluteString, expectedURLString)
       }

}
