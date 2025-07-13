//
//  ScoreHistoryView.swift
//  test0526
//
//  Created by inoue tomoki on 2025/07/03.
//


import SwiftUI

struct ScoreHistoryView: View {
    @State private var history: [DailyScore] = []

    var body: some View {
        VStack {
            Text("🗓 スコア履歴")
                .font(.largeTitle)
                .padding()

            List(history) { record in
                HStack {
                    Text(record.date)
                    Spacer()
                    Text("正解: \(record.correct) / \(record.total)")
                        .foregroundColor(.blue)
                }
            }

            Button("履歴をリセット") {
                ScoreManager.shared.resetHistory()
                history = []
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(10)
        }
        .onAppear {
            history = ScoreManager.shared.getHistory()
        }
    }
}

#Preview {
    ScoreHistoryView()
}
