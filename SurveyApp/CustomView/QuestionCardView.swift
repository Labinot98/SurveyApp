//
//  QuestionCardView.swift
//  SurveyApp
//
//  Created by Pajaziti Labinot on 30.3.24..
//

import SwiftUI

    struct QuestionCardView: View {
        let question: Question
        @Binding var answerText: String
        @ObservedObject var viewModel: SurveyViewModel
        
        var body: some View {
            VStack {
                Text("Question \(viewModel.currentQuestionIndex + 1) of \(viewModel.questions.count)")
                Text(question.question)
                    .font(.headline)
                    .foregroundColor(.gray)
                TextField("Enter your answer", text: $answerText)
                    .padding()
                    .frame(height: 50)
                    .border(.blue, width: 1)
            }
            .padding()
        }
    }
