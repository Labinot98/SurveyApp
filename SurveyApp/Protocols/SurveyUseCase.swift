//
//  SurveyUseCase.swift
//  SurveyApp
//
//  Created by Pajaziti Labinot on 31.3.24..
//

import Combine

protocol SurveyUseCase {
    func fetchQuestions() -> AnyPublisher<[Question], Error>
    func submitAnswer(answer: Answer) -> AnyPublisher<Void, Error>
}
