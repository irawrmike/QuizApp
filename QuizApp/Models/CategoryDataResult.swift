//
//  CategoryDataResult.swift
//  QuizApp
//
//  Created by Mike Stoltman on 2020-10-02.
//

import Foundation

struct CategoryDataResult: Codable {
    let results: [Category]
    
    enum CodingKeys: String, CodingKey {
        case results = "trivia_categories"
    }
}
