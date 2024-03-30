//
//  URLRequestBuilder.swift
//  SurveyApp
//
//  Created by Pajaziti Labinot on 30.3.24..
//

import Foundation

protocol URLRequestBuilder {
    func makeRequest(withPathComponent pathComponent: String) -> URLRequest
}
