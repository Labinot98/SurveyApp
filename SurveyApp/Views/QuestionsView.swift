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
    
    var body: some View {
        VStack {
            if let question = viewModel.currentQuestion {
                Text("Question \(viewModel.currentQuestionIndex + 1) of \(viewModel.questions.count)")
                
                Text(question.question)
                
                TextField("Enter your answer", text: $answerText)
                    .padding()
                
                HStack {
                    Button("Previous") {
                        viewModel.moveToPreviousQuestion()
                    }.disabled(viewModel.isPreviousButtonDisabled)
                    
                    Button("Submit") {
                        viewModel.submitAnswer(answerText: answerText)
                        answerText = ""
                    }.disabled(answerText.isEmpty || viewModel.hasSubmittedAnswer)
                    
                    Button("Next") {
                        viewModel.moveToNextQuestion()
                    }.disabled(viewModel.isNextButtonDisabled)
                }
                .padding()
                
                Text("Submitted: \(viewModel.submittedQuestionsCount)")
                    .padding(.top, 10)
                
                if let status = viewModel.submissionStatus {
                    Text(status == .success ? "Success!" : "Failure...")
                        .foregroundColor(status == .success ? .green : .red)
                        .padding()
                }
            } else {
                Text("No questions available")
            }
            
            Spacer()
        }.onDisappear {
            viewModel.resetSurvey()
        }
    }
}
