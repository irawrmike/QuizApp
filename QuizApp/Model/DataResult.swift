//
//  DataResult.swift
//  QuizApp
//
//  Created by Mike Stoltman on 2020-10-01.
//

import Foundation

struct DataResult: Codable {
    let response: Int
    let results: [Question]
    
    enum CodingKeys: String, CodingKey {
        case results
        case response = "response_code"
    }
}
