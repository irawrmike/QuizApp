//
//  AnswerView.swift
//  QuizApp
//
//  Created by Mike Stoltman on 2020-10-02.
//

import UIKit

class AnswerView: UIView {
    private let answerBackgroundView = UIView(frame: CGRect.zero)
    let answerLabel = UILabel(frame: CGRect.zero)
    let answerButton = UIButton(frame: CGRect.zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(answerBackgroundView)
        answerBackgroundView.layer.borderWidth = 1.0
        answerBackgroundView.layer.borderColor = UIColor.gray.cgColor
        answerBackgroundView.layer.cornerRadius = 10.0
        
        answerBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        answerBackgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        answerBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        answerBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        answerBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        
        addSubview(answerLabel)
        answerLabel.numberOfLines = 0
        answerLabel.textAlignment = NSTextAlignment.center
        
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.topAnchor.constraint(equalTo: answerBackgroundView.topAnchor, constant: 10.0).isActive = true
        answerLabel.bottomAnchor.constraint(equalTo: answerBackgroundView.bottomAnchor, constant: -10.0).isActive = true
        answerLabel.leadingAnchor.constraint(equalTo: answerBackgroundView.leadingAnchor, constant: 10.0).isActive = true
        answerLabel.trailingAnchor.constraint(equalTo: answerBackgroundView.trailingAnchor, constant: -10.0).isActive = true
        
        addSubview(answerButton)
        
        answerButton.translatesAutoresizingMaskIntoConstraints = false
        answerButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        answerButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        answerButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        answerButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
