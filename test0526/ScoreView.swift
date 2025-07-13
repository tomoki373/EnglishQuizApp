import SwiftUI

struct ScoreView: View {
    var correct: Int {
        ScoreManager.shared.getCorrect()
    }

    var total: Int {
        ScoreManager.shared.getTotal()
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("📈 成績")
                .font(.largeTitle)
                .bold()

            Text("正解数: \(correct)")
            Text("問題数: \(total)")
            Text("正答率: \(total > 0 ? Int(Double(correct) / Double(total) * 100) : 0)%")
                .font(.title2)
                .foregroundColor(.blue)

            Button("スコアをリセット") {
                ScoreManager.shared.reset()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)

            Spacer()
        }
        .padding()
    }
}
