// ✅ Word 構造体の代わりに QuizWord を使うようにする

import Foundation

struct QuizWord {
    let english: String
    let japanese: String
}

class CSVLoader {
    static func loadCSV(fileName: String) -> [QuizWord] {
        var wordList: [QuizWord] = []

        guard let path = Bundle.main.path(forResource: fileName, ofType: "csv") else {
            print("❌ CSVファイルが見つかりません: \(fileName)")
            return []
        }

        do {
            let csvString = try String(contentsOfFile: path, encoding: .utf8)
            let lines = csvString.components(separatedBy: .newlines)
            
            for line in lines {
                let fields = line.components(separatedBy: ",")
                if fields.count == 2 {
                    let word = QuizWord(english: fields[0].trimmingCharacters(in: .whitespaces),
                                        japanese: fields[1].trimmingCharacters(in: .whitespaces))
                    wordList.append(word)
                }
            }
            print("✅ 読み込んだ単語数: \(wordList.count)")
        } catch {
            print("❌ CSV読み込みエラー: \(error.localizedDescription)")
        }

        return wordList
    }
}
