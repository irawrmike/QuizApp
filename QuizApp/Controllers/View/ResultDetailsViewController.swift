//
//  ResultDetailsViewController.swift
//  QuizApp
//
//  Created by Mike Stoltman on 2020-10-03.
//

import UIKit

class ResultDetailsViewController: UIViewController {
    
    var result: Result?
    
    private let scrollView = UIScrollView(frame: CGRect.zero)
    
    private let questionLabel = UILabel(frame: CGRect.zero)
    private let submittedAnswerLabel = UILabel(frame: CGRect.zero)
    private let correctAnswerLabel = UILabel(frame: CGRect.zero)
    private let answerPointsLabel = UILabel(frame: CGRect.zero)
    private let timeLabel = UILabel(frame: CGRect.zero)
    private let timePointsLabel = UILabel(frame: CGRect.zero)
    private let totalPointsLabel = UILabel(frame: CGRect.zero)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshViews()
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        
        scrollView.addSubview(questionLabel)
        questionLabel.textAlignment = NSTextAlignment.center
        questionLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
        questionLabel.numberOfLines = 0
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20.0).isActive = true
        questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
        questionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true
        
        
        scrollView.addSubview(submittedAnswerLabel)
        submittedAnswerLabel.textAlignment = NSTextAlignment.center
        submittedAnswerLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        submittedAnswerLabel.numberOfLines = 0
        
        submittedAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
        submittedAnswerLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20.0).isActive = true
        submittedAnswerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
        submittedAnswerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true
        
        
        scrollView.addSubview(correctAnswerLabel)
        correctAnswerLabel.textAlignment = NSTextAlignment.center
        correctAnswerLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        correctAnswerLabel.numberOfLines = 0
        
        correctAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
        correctAnswerLabel.topAnchor.constraint(equalTo: submittedAnswerLabel.bottomAnchor, constant: 20.0).isActive = true
        correctAnswerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
        correctAnswerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true
        
        
        scrollView.addSubview(answerPointsLabel)
        answerPointsLabel.textAlignment = NSTextAlignment.center
        answerPointsLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
        answerPointsLabel.numberOfLines = 1
        
        answerPointsLabel.translatesAutoresizingMaskIntoConstraints = false
        answerPointsLabel.topAnchor.constraint(equalTo: correctAnswerLabel.bottomAnchor, constant: 20.0).isActive = true
        answerPointsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
        answerPointsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true
        
        
        scrollView.addSubview(timeLabel)
        timeLabel.textAlignment = NSTextAlignment.center
        timeLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        timeLabel.numberOfLines = 0
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: answerPointsLabel.bottomAnchor, constant: 20.0).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true
        
        
        scrollView.addSubview(timePointsLabel)
        timePointsLabel.textAlignment = NSTextAlignment.center
        timePointsLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
        timePointsLabel.numberOfLines = 1
        
        timePointsLabel.translatesAutoresizingMaskIntoConstraints = false
        timePointsLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 20.0).isActive = true
        timePointsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
        timePointsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true
        
        
        scrollView.addSubview(totalPointsLabel)
        totalPointsLabel.textAlignment = NSTextAlignment.center
        totalPointsLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
        totalPointsLabel.numberOfLines = 0
        
        totalPointsLabel.translatesAutoresizingMaskIntoConstraints = false
        totalPointsLabel.topAnchor.constraint(equalTo: timePointsLabel.bottomAnchor, constant: 20.0).isActive = true
        totalPointsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
        totalPointsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true
    }
    
    private func refreshViews() {
        if let result = result {
            questionLabel.text = result.question.question
            submittedAnswerLabel.text = "You answered:\n\(result.answer.givenAnswer)"
            correctAnswerLabel.text = "The correct answer is:\n\(result.question.correctAnswer)"
            
            answerPointsLabel.text = "\(result.answerPoints)"
            if result.correct {
                answerPointsLabel.textColor = UIColor.green
            }else{
                answerPointsLabel.textColor = UIColor.red
            }
            
            let millisecs = Int((result.elapsedTime.truncatingRemainder(dividingBy: 1)) * 1000)
            let secs = Int(result.elapsedTime) % 60
            let mins = (Int(result.elapsedTime) / 60) % 60
            var timeLabelText = "It took you "
            if mins > 0 {
                timeLabelText += String(format: "%d minutes and ", mins)
            }
            timeLabelText += String(format: "%d.%0.3d seconds to answer.", secs, millisecs)
            timeLabel.text = timeLabelText
            
            timePointsLabel.text = "\(result.timePoints)"
            if result.timePoints == 0 {
                timePointsLabel.textColor = UIColor.red
            }else{
                timePointsLabel.textColor = UIColor.green
            }
            
            totalPointsLabel.text = "Total Points:\n\(result.pointsEarned)"
        }
    }
    
}
