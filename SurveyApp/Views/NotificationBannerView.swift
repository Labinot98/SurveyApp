//
//  NotificationBannerView.swift
//  SurveyApp
//
//  Created by Pajaziti Labinot on 30.3.24..
//

import SwiftUI

struct NotificationBannerView: View {
    @ObservedObject var viewModel: SurveyViewModel
    @Binding var answerText: String

    var body: some View {
        VStack {
            if let status = viewModel.submissionStatus {
                if status == .success {
                    Text("Success")
                        .foregroundColor(.green)
                        .padding()
                } else if status == .failure {
                    HStack {
                        Text("Failure")
                            .foregroundColor(.red)
                            .padding()
                        Button(action: {
                            viewModel.submitAnswer(answerText: answerText)
                            answerText = ""
                        }) {
                            Text("Retry")
                        }
                        .padding()
                    }
                }
            }
            Spacer()
        }
    }
}
