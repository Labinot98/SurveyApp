//
//  SurveyRepository.swift
//  SurveyApp
//
//  Created by Pajaziti Labinot on 30.3.24..
//

import Foundation
import Combine

protocol SurveyRepository {
    func fetchQuestions() -> AnyPublisher<[Question], Error>
    func submitAnswer(answer: Answer) -> AnyPublisher<Void, Error>
}
