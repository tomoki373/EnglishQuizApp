// QuizQuestion.swift (または別の適切なファイル)

import Foundation

struct QuizQuestion {
    var question: String
    var options: [String]
    var correctAnswer: String
}

let sampleQuizData: [QuizQuestion] = [
    QuizQuestion(
        question: "What is the capital of France?",
        options: ["Paris", "London", "Berlin", "Tokyo"],
        correctAnswer: "Paris"
    ),
    QuizQuestion(
        question: "What is the largest planet in our solar system?",
        options: ["Mars", "Earth", "Jupiter", "Saturn"],
        correctAnswer: "Jupiter"
    ),
    QuizQuestion(
        question: "Which language is primarily spoken in Brazil?",
        options: ["Spanish", "French", "Brazilian", "Portuguese"],
        correctAnswer: "Portuguese"
    )
]
