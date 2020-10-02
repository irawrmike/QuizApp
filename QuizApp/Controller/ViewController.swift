//
//  ViewController.swift
//  QuizApp
//
//  Created by Mike Stoltman on 2020-10-01.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let networkController = NetworkController()
        networkController.getQuestions(amount: 20, category: nil, difficulty: nil, type: nil) { (questions, error) in
            
        }
    }

}
