//
//  Question.swift
//  QuizApp
//
//  Created by Mike Stoltman on 2020-10-01.
//

import Foundation

struct Question: Codable {
    let category: String
    let type: QuestionType
    let difficulty: Difficulty
    var question: String {
        return questionText.removingPercentEncoding ?? questionText
    }
    private let questionText: String
    var correctAnswer: String {
        return correctAnswerText.removingPercentEncoding ?? correctAnswerText
    }
    private let correctAnswerText: String
    var incorrectAnswers: [String] {
        var answers = incorrectAnswersList
        for i in 0..<incorrectAnswersList.count {
            answers[i] = incorrectAnswersList[i].removingPercentEncoding ?? incorrectAnswersList[i]
        }
        return answers
    }
    private let incorrectAnswersList: [String]
    
    enum CodingKeys: String, CodingKey {
        case category
        case type
        case difficulty
        case questionText = "question"
        case correctAnswerText = "correct_answer"
        case incorrectAnswersList = "incorrect_answers"
    }
}

