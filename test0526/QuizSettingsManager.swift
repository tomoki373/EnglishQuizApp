//
//  QuizSettingsManager.swift
//  test0526
//
//  Created by inoue tomoki on 2025/07/03.
//


import Foundation

class QuizSettingsManager {
    static let shared = QuizSettingsManager()
    
    private let questionCountKey = "questionCount"

    private init() {}

    func getQuestionCount() -> Int {
        let count = UserDefaults.standard.integer(forKey: questionCountKey)
        return count == 0 ? 5 : count  // デフォルトは5問
    }

    func setQuestionCount(_ count: Int) {
        UserDefaults.standard.set(count, forKey: questionCountKey)
    }
}
