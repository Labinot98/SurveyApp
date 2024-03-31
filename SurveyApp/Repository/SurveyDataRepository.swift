//
//  SurveyDataRepository.swift
//  SurveyApp
//
//  Created by Pajaziti Labinot on 31.3.24..
//

import Foundation
import Combine

class SurveyDataRepository: SurveyRepository {
    
    private let urlRequestBuilder: URLRequestBuilder
    
    init(urlRequestBuilder: URLRequestBuilder = SurveyURLRequestBuilder()) {
        self.urlRequestBuilder = urlRequestBuilder
    }
    
    func fetchQuestions() -> AnyPublisher<[Question], Error> {
        let request = urlRequestBuilder.makeRequest(withPathComponent: "/questions")
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [Question].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func submitAnswer(answer: Answer) -> AnyPublisher<Void, Error> {
        var request = urlRequestBuilder.makeRequest(withPathComponent: "/question/submit")
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(answer)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
            }
            .mapError { error -> Error in return error }
            .map { _ in }
            .eraseToAnyPublisher()
    }
}


