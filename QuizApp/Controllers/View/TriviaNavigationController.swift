//
//  TriviaNavigationController.swift
//  QuizApp
//
//  Created by Mike Stoltman on 2020-10-02.
//

import UIKit

class TriviaNavigationController: UINavigationController {
    private let networkController = NetworkController()
    
    var category: Category? {
        didSet {
            if let id = category?.id {
                categorySelected(id: id)
            }
        }
    }
    
    private let questionCount: Int = 1
    private var questions: [Question]?
    private var currentQuestionIndex: Int = 0
    private var answers: [Answer] = []
    
    
    private func resetGame() {
        questions = nil
        currentQuestionIndex = 0
        answers.removeAll()
    }
    
    private func categorySelected(id: Int) {
        networkController.getQuestions(amount: questionCount, category: id, difficulty: nil, type: nil) { [weak self] (questions, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                DispatchQueue.main.async {
                    self?.resetGame()
                    self?.questions = questions
                    guard let questionViewController = self?.storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as? QuestionViewController else { return }
                    questionViewController.currentQuestionIndex = 0
                    questionViewController.totalQuestionCount = questions?.count ?? 0
                    questionViewController.question = questions?.first
                    self?.pushViewController(questionViewController, animated: true)
                }
            }
        }
    }
    
    func answerSelected(_ answer: String, time: TimeInterval) {
        answers.append(Answer(givenAnswer: answer, timeTaken: time))
        
        if let questions = questions {
            currentQuestionIndex += 1
            
            if answers.count == questions.count {
                guard let resultsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ResultsViewController") as? ResultsViewController else { return }
                var results: [Result] = []
                for i in 0..<questionCount {
                    results.append(Result(question: questions[i], answer: answers[i]))
                }
                resultsViewController.results = results
                self.pushViewController(resultsViewController, animated: true)
            }else{
                guard let questionViewController = self.storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as? QuestionViewController else { return }
                questionViewController.question = questions[currentQuestionIndex]
                questionViewController.currentQuestionIndex = currentQuestionIndex
                questionViewController.totalQuestionCount = questions.count
                self.pushViewController(questionViewController, animated: true)
            }
        }
    }
    
}
