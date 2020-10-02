//
//  Token.swift
//  QuizApp
//
//  Created by Mike Stoltman on 2020-10-01.
//

import Foundation

struct Token: Codable {
    let response: ResponseCode?
    let message: String?
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case response
        case message = "response_message"
        case token
    }
}
