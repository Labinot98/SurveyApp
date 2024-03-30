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
    @Published var submissionStatus: SubmissionStatus?
    
    private var cancellables = Set<AnyCancellable>()
    var submittedQuestionsCount: Int {
           submittedAnswers.count
       }
    
    enum SubmissionStatus {
        case success
        case failure
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

    func submitAnswer(answerText: String) {
        guard !answerText.isEmpty else { return }
        guard let currentQuestion = questions[safe: currentQuestionIndex] else { return }
        
        let answer = Answer(id: currentQuestion.id, answer: answerText)
        submittedAnswers[currentQuestion.id] = answer

        let url = URL(string: "https://xm-assignment.web.app/question/submit")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(answer)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.response as? HTTPURLResponse }
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


