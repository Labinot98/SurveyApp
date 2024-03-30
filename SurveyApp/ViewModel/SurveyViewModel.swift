//
//  SurveyViewModel.swift
//  SurveyApp
//
//  Created by Pajaziti Labinot on 30.3.24..
//

import Combine
import SwiftUI

class SurveyViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex = 0
    @Published var submittedAnswers: [Int: Answer] = [:]
    
    private var cancellables = Set<AnyCancellable>()
    var submittedQuestionsCount: Int {
           submittedAnswers.count
       }
    

    func fetchQuestions() {
        URLSession.shared.dataTaskPublisher(for: URL(string: "https://xm-assignment.web.app/questions")!)
            .map { $0.data }
            .decode(type: [Question].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] questions in
                self?.questions = questions
            })
            .store(in: &cancellables)
    }
   
}


