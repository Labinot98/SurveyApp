//
//  SurveyModel.swift
//  SurveyApp
//
//  Created by Pajaziti Labinot on 30.3.24..
//

import Foundation

struct Question: Codable {
    let id: Int
    let question: String
}

struct Answer: Codable {
    let id: Int
    let answer: String
}
