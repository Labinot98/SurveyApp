//
//  QuestionsView.swift
//  SurveyApp
//
//  Created by Pajaziti Labinot on 30.3.24..
//

import SwiftUI

struct QuestionsView: View {
    @ObservedObject var viewModel: SurveyViewModel
    @State private var answerText = ""
    
    var currentQuestion: Question? {
        viewModel.questions[safe: viewModel.currentQuestionIndex]
    }
    
    var isPreviousButtonDisabled: Bool {
        viewModel.currentQuestionIndex == 0
    }
    
    var isNextButtonDisabled: Bool {
        viewModel.currentQuestionIndex == viewModel.questions.count - 1
    }
    
    var hasSubmittedAnswer: Bool {
        guard let question = currentQuestion else { return false }
        return viewModel.submittedAnswers[question.id] != nil
    }
    
    var body: some View {
        VStack {
            if let question = currentQuestion {
                Text("Question \(viewModel.currentQuestionIndex + 1) of \(viewModel.questions.count)")
                
                Text(question.question)
                
                TextField("Enter your answer", text: $answerText)
                    .padding()
                
                HStack {
                    Button("Previous") {
                        print("Previous")
                    }.disabled(isPreviousButtonDisabled)
                    
                    Button("Submit") {
                        viewModel.submitAnswer(answerText: answerText)
                        answerText = ""
                    }.disabled(answerText.isEmpty || hasSubmittedAnswer)
                    
                    Button("Next") {
                        print("Next")
                    }.disabled(isNextButtonDisabled)
                }
                .padding()
            
                
                if let status = viewModel.submissionStatus {
                    Text(status == .success ? "Success!" : "Failure...")
                        .foregroundColor(status == .success ? .green : .red)
                        .padding()
                }
            } else {
                Text("No questions available")
            }
            
            Spacer()
        }
    }
}
