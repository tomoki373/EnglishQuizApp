import SwiftUI

struct QuizView: View {
    @State private var wordList: [QuizWord] = []
    @State private var currentQuestion: QuizWord?
    @State private var choices: [String] = []
    @State private var resultMessage: String = ""
    @State private var showResult = false

    // ✅ スコア用
    @State private var score = 0
    @State private var totalQuestions = 0
    @State private var currentQuestionIndex = 0
    
    @State private var showFinalScore = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("英単語クイズ")
                    .font(.largeTitle)
                    .bold()
                
                Text("第 \(min(currentQuestionIndex + 1, totalQuestions)) 問 / 全 \(totalQuestions) 問")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                // ✅ スコア表示
                Text("スコア: \(score) / \(totalQuestions)")
                    .font(.title3)
                    .foregroundColor(.gray)
                
                if let question = currentQuestion {
                    Text("「\(question.japanese)」の英語は？")
                        .font(.title2)
                    
                    ForEach(choices, id: \.self) { choice in
                        Button(action: {
                            checkAnswer(selected: choice)
                        }) {
                            Text(choice)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.7))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .disabled(showResult) // ✅ 回答後は選択肢ボタンを無効にする
                    }
                    
                    
                    if showResult {
                        Text(resultMessage)
                            .font(.headline)
                            .foregroundColor(resultMessage == "正解！" ? .green : .red)
                        
                        Button(currentQuestionIndex == totalQuestions - 1 ? "最後の問題" : "次の問題へ") {
                            currentQuestionIndex += 1
                            if currentQuestionIndex >= totalQuestions {
                                showFinalScore = true
                            } else {
                                setupQuiz()
                            }
                        }
                        .padding(.top)
                    }
                } else {
                    Text("単語を読み込み中...")
                }
            }
            .padding()
            .onAppear {
                wordList = CSVLoader.loadCSV(fileName: "words")  // 拡張子なし
                print("✅ 読み込んだ単語数: \(wordList.count)") // ← デバッグ用
                score = 0
                totalQuestions = QuizSettingsManager.shared.getQuestionCount()
                currentQuestionIndex = 0
                setupQuiz()
            }

            
            NavigationLink(
                destination: FinalScoreView(score: score, total: totalQuestions),
                isActive: $showFinalScore
            ) {
                EmptyView()
            }
        }

    }

    func setupQuiz() {
        showResult = false
        resultMessage = ""

        // ✅ 出題数を超えたら終了
        if currentQuestionIndex >= totalQuestions {
            showFinalScore = true
            return
        }

        guard wordList.count >= 4 else {
            currentQuestion = nil
            choices = []
            return
        }

        currentQuestion = wordList.randomElement()

        if let correct = currentQuestion {
            var options = Set<String>()
            options.insert(correct.english)
            while options.count < 4 {
                if let random = wordList.randomElement()?.english {
                    options.insert(random)
                }
            }
            choices = Array(options).shuffled()
        }
    }


    func checkAnswer(selected: String) {
        let isCorrect = (selected == currentQuestion?.english)
        if isCorrect {
            score += 1
            resultMessage = "正解！"
        } else {
            resultMessage = "不正解… 答え: \(currentQuestion?.english ?? "")"
        }

        ScoreManager.shared.addResult(isCorrect: isCorrect)
        ScoreManager.shared.addDailyResult(isCorrect: isCorrect)

        showResult = true

    }

}
