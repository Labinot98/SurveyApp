//
//  SurveyInteractor.swift
//  SurveyApp
//
//  Created by Pajaziti Labinot on 30.3.24..
//

import Combine

class SurveyInteractor: SurveyUseCase {
    private let repository: SurveyRepository
    
    init(repository: SurveyRepository) {
        self.repository = repository
    }
    
    func fetchQuestions() -> AnyPublisher<[Question], Error> {
        repository.fetchQuestions()
    }
    
    func submitAnswer(answer: Answer) -> AnyPublisher<Void, Error> {
        repository.submitAnswer(answer: answer)
    }
}
