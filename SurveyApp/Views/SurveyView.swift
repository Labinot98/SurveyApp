//
//  SurveyView.swift
//  SurveyApp
//
//  Created by Pajaziti Labinot on 30.3.24..
//

import SwiftUI

struct SurveyView: View {
    @StateObject var viewModel = SurveyViewModel()
    @State private var isSurveyStarted = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: QuestionsView(viewModel: viewModel),
                    isActive: $isSurveyStarted,
                    label: { EmptyView() }
                )
                
                Button("Start Survey") {
                    isSurveyStarted = true
                }
            }
            .padding()
            .navigationBarTitle("Survey")
            .navigationBarBackButtonHidden(true)
        }
        .onAppear {
            viewModel.fetchQuestions()
        }
    }
}


//#Preview {
//    SurveyView()
//}
