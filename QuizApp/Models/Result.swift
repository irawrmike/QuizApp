//
//  Result.swift
//  QuizApp
//
//  Created by Mike Stoltman on 2020-10-03.
//

import Foundation

struct Result {
    let question: Question
    let answer: Answer
    var correct: Bool {
        return answer.givenAnswer == question.correctAnswer
    }
    var elapsedTime: TimeInterval {
        return answer.timeTaken
    }
    var difficulty: Difficulty {
        return question.difficulty
    }
    
    static let timePointsMultiplier: Double = 1000 // milliseconds count toward points
    static let maximumTimeAllowed: Double = 8.4 * 60 // 8.4 minutes max; ~500K points
    static let correctAnswerPoints: Int = 500000 // ~1M points available
    
    var answerPoints: Int {
        if self.correct {
            return Result.correctAnswerPoints
        }else{
            return 0
        }
    }
    
    var timePoints: Int {
        var points: Int = 0
        if elapsedTime <= Result.maximumTimeAllowed {
            let timeDiff = Result.maximumTimeAllowed - elapsedTime
            points += Int(round(timeDiff * Result.timePointsMultiplier))
        }
        return points
    }
    
    var pointsEarned: Int {
        return self.answerPoints + self.timePoints
    }
    
}
