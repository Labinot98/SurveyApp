//
//  Array+Extension.swift
//  SurveyApp
//
//  Created by Pajaziti Labinot on 30.3.24..
//


extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
