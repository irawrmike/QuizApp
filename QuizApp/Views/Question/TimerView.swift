//
//  TimerView.swift
//  QuizApp
//
//  Created by Mike Stoltman on 2020-10-02.
//

import UIKit

class TimerView: UIView {
    
    let timerLabel = UILabel(frame: CGRect.zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(timerLabel)
        timerLabel.textAlignment = NSTextAlignment.center
        timerLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1)
        timerLabel.numberOfLines = 1
        timerLabel.text = "0:00:000"
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        timerLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        timerLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        timerLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
