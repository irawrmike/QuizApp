//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Mike Stoltman on 2020-10-02.
//

import UIKit

class QuestionViewController: UIViewController {
    
    private let difficultyLabel = UILabel(frame: CGRect.zero)
    private let questionIndexLabel = UILabel(frame: CGRect.zero)
    private let timerView = TimerView(frame: CGRect.zero)
    private let questionView = QuestionView(frame: CGRect.zero)
    private let answerStackView = UIStackView(frame: CGRect.zero)
    
    var currentQuestionIndex: Int = 0
    var totalQuestionCount: Int = 0
    var question: Question?
    var correctAnswerIndex: Int?
    private var currentAnswers: [String] = []
    
    private var timer: Timer?
    private var startTime: Date!
    private var currentTime: Date!
    
    
    deinit {
        timer?.invalidate()
    }
    
    // MARK: View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.setHidesBackButton(true, animated: true)
        
        setupAnswerStackView()
        setupLabels()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupTimer()
    }
    
    private func setupViews() {
        view.addSubview(difficultyLabel)
        difficultyLabel.textAlignment = NSTextAlignment.center
        
        difficultyLabel.translatesAutoresizingMaskIntoConstraints = false
        difficultyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0).isActive = true
        difficultyLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
        difficultyLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true
        
        
        view.addSubview(timerView)
        
        timerView.translatesAutoresizingMaskIntoConstraints = false
        timerView.topAnchor.constraint(equalTo: difficultyLabel.bottomAnchor, constant: 20.0).isActive = true
        timerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
        timerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true
        
        
        view.addSubview(questionIndexLabel)
        questionIndexLabel.textAlignment = NSTextAlignment.center
        
        questionIndexLabel.translatesAutoresizingMaskIntoConstraints = false
        questionIndexLabel.topAnchor.constraint(equalTo: timerView.bottomAnchor, constant: 40.0).isActive = true
        questionIndexLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
        questionIndexLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true
        
        
        view.addSubview(questionView)
        
        questionView.translatesAutoresizingMaskIntoConstraints = false
        questionView.topAnchor.constraint(equalTo: questionIndexLabel.bottomAnchor, constant: 20.0).isActive = true
        questionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
        questionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true
        
        
        view.addSubview(answerStackView)
        answerStackView.alignment = UIStackView.Alignment.center
        answerStackView.axis = .vertical
        answerStackView.distribution = .fillEqually
        answerStackView.spacing = 20.0
        
        answerStackView.translatesAutoresizingMaskIntoConstraints = false
        answerStackView.topAnchor.constraint(equalTo: questionView.bottomAnchor, constant: 40.0).isActive = true
        answerStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0).isActive = true
        answerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
        answerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true
        
    }
    
    private func setupAnswerStackView() {
        if let question = question {
            questionView.questionLabel.text = question.question
            
            currentAnswers = question.incorrectAnswers
            currentAnswers.append(question.correctAnswer)
            currentAnswers.shuffle()
            
            for i in 0..<currentAnswers.count {
                if currentAnswers[i] == question.correctAnswer {
                    correctAnswerIndex = i
                }
                let answerView = AnswerView(frame: CGRect.zero)
                answerView.answerButton.tag = i
                answerView.answerButton.addTarget(self, action: #selector(answerButtonTapped(sender:)), for: .touchUpInside)
                answerView.answerLabel.text = currentAnswers[i]
                answerStackView.addArrangedSubview(answerView)
            }
        }
    }
    
    private func setupLabels() {
        if let question = question {
            switch question.difficulty {
            case .easy: difficultyLabel.text = "Difficulty: Easy"
            case .medium: difficultyLabel.text = "Difficulty: Medium"
            case .hard: difficultyLabel.text = "Difficulty: Hard"
            }
        }
        
        if (currentQuestionIndex + 1) == totalQuestionCount {
            questionIndexLabel.text = "Final Question:"
        }else{
            questionIndexLabel.text = "Question \(currentQuestionIndex + 1) of \(totalQuestionCount):"
        }
    }
    
    // MARK: Timer
    
    private func setupTimer() {
        startTime = Date()
        currentTime = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: { [unowned self] (timer) in
            self.currentTime = Date()
            let elapsedTime = self.currentTime.timeIntervalSince(self.startTime)
            let timeInterval = NSInteger(elapsedTime)
            let millisecs = Int((elapsedTime.truncatingRemainder(dividingBy: 1)) * 1000)
            let secs = timeInterval % 60
            let mins = (timeInterval / 60) % 60
            self.timerView.timerLabel.text = String(format: "%0.2d:%0.2d:%0.3d",mins,secs,millisecs)
        })
    }
    
}

// MARK: Button Functions
extension QuestionViewController {
    @objc func answerButtonTapped(sender: UIButton) {
        guard let timer = timer else { return }
        timer.invalidate()
        currentTime = Date()
        guard let navigationController = navigationController as? TriviaNavigationController else { return }
        let elapsedTime = currentTime.timeIntervalSince(startTime)
        navigationController.answerSelected(currentAnswers[sender.tag], time: elapsedTime)
    }
}
