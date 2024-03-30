//
//  DefaultURLRequestBuilder.swift
//  SurveyApp
//
//  Created by Pajaziti Labinot on 30.3.24..
//

import Foundation

class DefaultURLRequestBuilder: URLRequestBuilder {
    private let baseURL = URL(string: "https://xm-assignment.web.app")!
    
    func makeRequest(withPathComponent pathComponent: String) -> URLRequest {
        let url = baseURL.appendingPathComponent(pathComponent)
        return URLRequest(url: url)
    }
}
