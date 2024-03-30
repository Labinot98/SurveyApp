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
            if viewModel.questions.isEmpty {
                Text("No questions available")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                TabView(selection: $viewModel.currentQuestionIndex) {
                    ForEach(0..<viewModel.questions.count, id: \.self) { index in
                        QuestionCardView(question: viewModel.questions[index], answerText: $answerText, viewModel: viewModel)
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .padding(.bottom, 20)
                
                Text("Submitted: \(viewModel.submittedQuestionsCount)")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.top, 10)
                
                HStack {
                    Button(action: {
                        viewModel.moveToPreviousQuestion()
                    }) {  Text("Previous") }
                    .padding()
                    .disabled(viewModel.isPreviousButtonDisabled)
                    
                    Button(action: {
                        viewModel.submitAnswer(answerText: answerText)
                        answerText = ""
                    }) {
                        Text(viewModel.hasSubmittedAnswer ? "Submitted" : "Submit")
                    }
                    .disabled(answerText.isEmpty || viewModel.hasSubmittedAnswer)
                    
                    Button(action: {
                        viewModel.moveToNextQuestion()
                    }) { Text("Next") }
                    .padding()
                    .disabled(viewModel.isNextButtonDisabled)
                }
                .padding(.horizontal, 20)
                
                NotificationBannerView(viewModel: viewModel, answerText: $answerText)
                    .padding(.horizontal, 20)
            }
            Spacer()
        }
        .onDisappear {
            viewModel.resetSurvey()
        }
    }
}
