import SwiftUI

struct ContentView: View {
    @State private var wordList: [Word] = []
    @State private var currentIndex = 0

    var body: some View {
        NavigationStack { // ← NavigationStack で囲む
            VStack(spacing: 30) {
                Text("英単語暗記")
                    .font(.largeTitle)
                    .bold()
                
                if !wordList.isEmpty {
                    Text(wordList[currentIndex].english)
                        .font(.title)
                    
                    Text(wordList[currentIndex].japanese)
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    Button("次へ") {
                        currentIndex = (currentIndex + 1) % wordList.count
                    }
                    .font(.title2)
                    .padding()
                    .frame(width: 200)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                } else {
                    Text("データを読み込み中...")
                }

                Divider()

                // ✅ ボタン追加：画面遷移用
                NavigationLink("単語管理へ", destination: WordManagerView())
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                // クイズ画面を作る場合はもう1つ
                NavigationLink("クイズへ", destination: QuizView())
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)

            }
            .padding()
            .onAppear {
                WordDB.shared.insertSampleData() // テスト用
                wordList = WordDB.shared.fetchWords()
            }
        }
    }
}

#Preview {
    ContentView()
}
