//
//  NetworkController.swift
//  QuizApp
//
//  Created by Mike Stoltman on 2020-10-01.
//


//  Trivia API
//  The Open Trivia Database provides a completely free JSON API for use in programming projects. Use of this API does not require a API Key, just generate the URL below use it in your own application to retrieve trivia questions.
//
//  All data provided by the API is available under the Creative Commons Attribution-ShareAlike 4.0 International License.

import Foundation

class NetworkController {
    private let triviaAPIScheme = "https"
    private let triviaAPIDomain = "opentdb.com"
    private let triviaAPIDefaultPath = "/api.php"
    private let triviaAPICategoryPath = "/api_category.php"
    private let triviaAPICountPath = "/api_count.php"
    private let triviaAPITokenPath = "/api_token.php"
    private var triviaAPIURL: URL?
    
    private let defaultQuestionAmount = 10
    
    private func constructURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = triviaAPIScheme
        components.host = triviaAPIDomain
        return components
    }
    
    private func constructURL(amount: Int?, category: Int?, difficulty: Difficulty?, type: QuestionType?) -> URL? {
        var components = constructURLComponents()
        components.path = triviaAPIDefaultPath
        
        var queryItems: [URLQueryItem] = []
        if let amount = amount, amount > 0 {
            queryItems.append(URLQueryItem(name: "amount", value: String(amount)))
        }else{
            queryItems.append(URLQueryItem(name: "amount", value: String(defaultQuestionAmount)))
        }
        if let category = category {
            queryItems.append(URLQueryItem(name: "category", value: String(category)))
        }
        if let difficulty = difficulty {
            queryItems.append(URLQueryItem(name: "difficulty", value: difficulty.rawValue))
        }
        if let type = type {
            queryItems.append(URLQueryItem(name: "type", value: type.rawValue))
        }
        // Forcing API encoding method to URL Encoding RFC 3986
        queryItems.append(URLQueryItem(name: "encode", value: "url3986"))
        components.queryItems = queryItems
        
        return components.url
    }
    
    private func constructCategoryURL() -> URL? {
        var components = constructURLComponents()
        components.path = triviaAPICategoryPath
        return components.url
    }
    
    func getCategories(completion: @escaping (_ categories: [Category]?, _ error: NSError?) -> Void) {
        if let url = constructCategoryURL() {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error as NSError? {
                    completion(nil, error)
                }else{
                    let response = response as! HTTPURLResponse
                    switch response.statusCode {
                    case (200...299):
                        if let data = data {
                            do {
                                let dataResult = try JSONDecoder().decode(CategoryDataResult.self, from: data)
                                completion(dataResult.results, nil)
                            }catch{
                                completion(nil, ResponseCode.JSONDecoderError as NSError?)
                            }
                        }
                    default:
                        completion(nil, ResponseCode.ServerError as NSError?)
                    }
                }
            }.resume()
        }else{
            completion(nil, ResponseCode.InvalidCategoryURL as NSError?)
        }
    }
    
    func getQuestions(amount: Int?, category: Int?, difficulty: Difficulty?, type: QuestionType?, completion: @escaping (_ questions: [Question]?, _ error: NSError?) -> Void) {
        if let url = constructURL(amount: amount, category: category, difficulty: difficulty, type: type) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error as NSError? {
                    completion(nil, error)
                }else{
                    let response = response as! HTTPURLResponse
                    switch response.statusCode {
                    case (200...299):
                        if let data = data {
                            do {
                                let dataResult = try JSONDecoder().decode(DataResult.self, from: data)
                                completion(dataResult.results, nil)
                            }catch let error {
                                print(error.localizedDescription)
                                completion(nil, error as NSError?)
                            }
                        }
                    default:
                        completion(nil, ResponseCode.ServerError as NSError?)
                    }
                }
            }.resume()
        }else{
            completion(nil, ResponseCode.InvalidURL as NSError?)
        }
    }
    
}
