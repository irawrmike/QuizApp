//
//  QuestionView.swift
//  QuizApp
//
//  Created by Mike Stoltman on 2020-10-02.
//

import UIKit

class QuestionView: UIView {
    private let questionBackgroundView = UIView(frame: CGRect.zero)
    let questionLabel = UILabel(frame: CGRect.zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(questionBackgroundView)
        questionBackgroundView.layer.borderWidth = 1.0
        questionBackgroundView.layer.borderColor = UIColor.gray.cgColor
        questionBackgroundView.layer.cornerRadius = 10.0
        
        questionBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        questionBackgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        questionBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        questionBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        questionBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        
        addSubview(questionLabel)
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = NSTextAlignment.center
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.topAnchor.constraint(equalTo: questionBackgroundView.topAnchor, constant: 10.0).isActive = true
        questionLabel.bottomAnchor.constraint(equalTo: questionBackgroundView.bottomAnchor, constant: -10.0).isActive = true
        questionLabel.leadingAnchor.constraint(equalTo: questionBackgroundView.leadingAnchor, constant: 10.0).isActive = true
        questionLabel.trailingAnchor.constraint(equalTo: questionBackgroundView.trailingAnchor, constant: -10.0).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
