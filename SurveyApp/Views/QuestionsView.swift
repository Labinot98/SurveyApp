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
    
    
    var body: some View {
        VStack {
            if let question = currentQuestion {
                Text("Question \(viewModel.currentQuestionIndex + 1) of \(viewModel.questions.count)")
                
                Text(question.question)
                
                TextField("Enter your answer", text: $answerText)
                    .padding()
                
            } else {
                Text("No questions available")
            }
            
            Spacer()
        }
    }
}
