import SwiftUI

struct SettingsView: View {
    @State private var selectedCount = QuizSettingsManager.shared.getQuestionCount()
    let availableCounts = [5, 10, 15, 20]

    var body: some View {
        VStack(spacing: 30) {
            Text("⚙️ 設定")
                .font(.largeTitle)
                .bold()

            VStack(alignment: .leading) {
                Text("クイズの出題数:")
                    .font(.headline)

                Picker("出題数", selection: $selectedCount) {
                    ForEach(availableCounts, id: \.self) { count in
                        Text("\(count) 問")
                    }
                }
                .pickerStyle(.segmented)
            }

            Button("保存") {
                QuizSettingsManager.shared.setQuestionCount(selectedCount)
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)

            Spacer()
        }
        .padding()
    }
}
