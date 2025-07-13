//
//  ScoreManager.swift
//  test0526
//
//  Created by inoue tomoki on 2025/07/03.
//


import Foundation

// ✅ 👇 ここに追加（ScoreManagerの外）
struct DailyScore: Codable, Identifiable {
    let id = UUID()
    let date: String
    var correct: Int
    var total: Int
}

class ScoreManager {
    static let shared = ScoreManager()

    private let correctKey = "correctCount"
    private let totalKey = "totalCount"

    private init() {}

    func addResult(isCorrect: Bool) {
        var correct = UserDefaults.standard.integer(forKey: correctKey)
        var total = UserDefaults.standard.integer(forKey: totalKey)

        if isCorrect {
            correct += 1
        }
        total += 1

        UserDefaults.standard.set(correct, forKey: correctKey)
        UserDefaults.standard.set(total, forKey: totalKey)
    }

    func getCorrect() -> Int {
        return UserDefaults.standard.integer(forKey: correctKey)
    }

    func getTotal() -> Int {
        return UserDefaults.standard.integer(forKey: totalKey)
    }

    func reset() {
        UserDefaults.standard.set(0, forKey: correctKey)
        UserDefaults.standard.set(0, forKey: totalKey)
    }
    
    private let historyKey = "scoreHistory"

    func addDailyResult(isCorrect: Bool) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = formatter.string(from: Date())

        var history = getHistory()

        if let index = history.firstIndex(where: { $0.date == today }) {
            // 今日の記録がある場合 → 加算
            history[index].total += 1
            if isCorrect { history[index].correct += 1 }
        } else {
            // 今日の初記録
            let new = DailyScore(date: today, correct: isCorrect ? 1 : 0, total: 1)
            history.insert(new, at: 0)
        }

        saveHistory(history)
    }

    private func saveHistory(_ history: [DailyScore]) {
        if let data = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(data, forKey: historyKey)
        }
    }

    func getHistory() -> [DailyScore] {
        if let data = UserDefaults.standard.data(forKey: historyKey),
           let decoded = try? JSONDecoder().decode([DailyScore].self, from: data) {
            return decoded
        }
        return []
    }

    func resetHistory() {
        UserDefaults.standard.removeObject(forKey: historyKey)
    }

}
