//
//  ResponseCode.swift
//  QuizApp
//
//  Created by Mike Stoltman on 2020-10-01.
//

import Foundation

enum ResponseCode: Int, Error, Codable {
    case Success = 0
    // Success Returned results successfully.
    case NoResults = 1
    // No Results Could not return results. The API doesn't have enough questions for your query. (Ex. Asking for 50 Questions in a Category that only has 20.)
    case InvalidParams = 2
    // Invalid Parameter Contains an invalid parameter. Arguements passed in aren't valid. (Ex. Amount = Five)
    case TokenNotFound = 3
    // Token Not Found Session Token does not exist.
    case TokenResetRequired = 4
    // Token Empty Session Token has returned all possible questions for the specified query. Resetting the Token is necessary.
    case InvalidURL = 5
    case JSONDecoderError = 6
    case ServerError = 7
}
