//
//  WordDB.swift
//  test0526
//
//  Created by inoue tomoki on 2025/07/01.
//

import Foundation
import SQLite

class WordDB {
    static let shared = WordDB()
    
    private let db: Connection?
    private let words = Table("words")
    
    private let id = Expression<Int64>("id")
    private let english = Expression<String>("english")
    private let japanese = Expression<String>("japanese")
    
    private init() {
        // データベースのファイルパス（Documentsディレクトリ）
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let dbURL = urls[0].appendingPathComponent("words.sqlite3")
        print("📁 SQLiteのパス: \(dbURL.path)")

        do {
            db = try Connection(dbURL.path)
            createTable()
        } catch {
            db = nil
            print("DB接続失敗: \(error)")
        }
    }

    
    private func createTable() {
        do {
            try db?.run(words.create(ifNotExists: true) { t in
                t.column(id, primaryKey: .autoincrement)
                t.column(english, unique: true)
                t.column(japanese)
            })
        } catch {
            print("テーブル作成失敗: \(error)")
        }
    }
    
    func insertSampleData() {
        let samples = [
            ("apple", "りんご"),
            ("banana", "バナナ"),
            ("cat", "猫"),
            ("dog", "犬"),
            ("book", "本"),
            ("car", "車")
        ]
        for (en, ja) in samples {
            insertWord(english: en, japanese: ja)
        }
    }

    
    func fetchWords() -> [Word] {
        var result: [Word] = []
        do {
            for word in try db!.prepare(words) {
                let w = Word(
                    id: word[id],
                    english: word[english],
                    japanese: word[japanese]
                )
                result.append(w)
            }
        } catch {
            print("取得失敗: \(error)")
        }
        return result
    }
    
    // 単語追加
    func insertWord(english: String, japanese: String) {
        do {
            try db?.run(words.insert(self.english <- english, self.japanese <- japanese))
        } catch {
            print("追加失敗: \(error)")
        }
    }

    // 単語削除
    func deleteWord(id: Int64) {
        do {
            let target = words.filter(self.id == id)
            try db?.run(target.delete())
        } catch {
            print("削除失敗: \(error)")
        }
    }

}
