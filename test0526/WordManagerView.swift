//
//  WordManagerView.swift
//  test0526
//
//  Created by inoue tomoki on 2025/07/03.
//


import SwiftUI

struct WordManagerView: View {
    @State private var english = ""
    @State private var japanese = ""
    @State private var wordList: [Word] = []

    var body: some View {
        VStack {
            Text("単語の追加")
                .font(.title2)
            
            TextField("英単語", text: $english)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("日本語訳", text: $japanese)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button("追加") {
                WordDB.shared.insertWord(english: english, japanese: japanese)
                wordList = WordDB.shared.fetchWords()
                english = ""
                japanese = ""
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Divider().padding(.vertical)

            List {
                ForEach(wordList, id: \.id) { word in
                    HStack {
                        Text("\(word.english) - \(word.japanese)")
                        Spacer()
                        Button(action: {
                            WordDB.shared.deleteWord(id: word.id)
                            wordList = WordDB.shared.fetchWords()
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
        }
        .onAppear {
            wordList = WordDB.shared.fetchWords()
        }
    }
}
