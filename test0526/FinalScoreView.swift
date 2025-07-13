//
//  FinalScoreView.swift
//  test0526
//
//  Created by inoue tomoki on 2025/07/05.
//


import SwiftUI

struct FinalScoreView: View {
    let score: Int
    let total: Int

    var body: some View {
        VStack(spacing: 30) {
            Text("クイズ終了！")
                .font(.largeTitle)
                .bold()

            Text("あなたのスコアは")
                .font(.title2)

            Text("\(score) / \(total)")
                .font(.system(size: 50))
                .bold()
                .foregroundColor(.blue)

            NavigationLink("もう一度挑戦", destination: QuizView())
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding()
    }
}
