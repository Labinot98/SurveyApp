//
//  SurveyViewModel.swift
//  SurveyApp
//
//  Created by Pajaziti Labinot on 30.3.24..
//

import Combine
import SwiftUI

enum SubmissionStatus {
    case success
    case failure
}

class SurveyViewModel: ObservableObject {

    @Published var questions: [Question]             = []
    @Published var currentQuestionIndex              = 0
    @Published var submittedAnswers: [Int: Answer]   = [:]
    @Published var submissionStatus: SubmissionStatus?
    
    private var cancellables = Set<AnyCancellable>()
    private let useCase: SurveyUseCase
    
    var submittedQuestionsCount: Int {
        submittedAnswers.count
    }

    var currentQuestion: Question? {
        questions[safe: currentQuestionIndex]
    }

    var isPreviousButtonDisabled: Bool {
        currentQuestionIndex == 0
    }

    var isNextButtonDisabled: Bool {
        currentQuestionIndex == questions.count - 1
    }

    var hasSubmittedAnswer: Bool {
        guard let question = currentQuestion else { return false }
        return submittedAnswers[question.id] != nil
    }
    
    init(useCase: SurveyUseCase) {
        self.useCase = useCase
    }
    
    
    func fetchQuestions() {
            useCase.fetchQuestions()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { _ in },
                      receiveValue: { [weak self] questions in
                        self?.questions = questions
                      })
                .store(in: &cancellables)
        }
        
        func submitAnswer(answerText: String) {
            guard !answerText.isEmpty else { return }
            guard let currentQuestion = currentQuestion else { return }
            
            let answer = Answer(id: currentQuestion.id, answer: answerText)
            submittedAnswers[currentQuestion.id] = answer
            
            useCase.submitAnswer(answer: answer)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        self?.submissionStatus = .success
                    case .failure:
                        self?.submissionStatus = .failure
                    }
                }, receiveValue: { _ in })
                .store(in: &cancellables)
        }

    func moveToPreviousQuestion() {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
        }
    }

    func moveToNextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        }
    }
    
    func resetSurvey() {
        currentQuestionIndex = 0
        submittedAnswers = [:]
        submissionStatus = nil
    }
}

