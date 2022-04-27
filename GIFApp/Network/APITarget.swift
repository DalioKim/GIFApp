//
//  APITarget.swift
//  GIFApp
//
//  Created by 김동현 on 2022/04/27.
//

import Foundation
import Alamofire

protocol TargetType {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Parameters { get }
//    var headers: [String: String]? { get }
    var endPoint: URLRequest? { get }
}

enum APITarget {
    case search(query: String)
}

extension APITarget {
    static private let clientId = "TWoWW_E7wbQRF4USjpy9"
    static private let clientKey = "Q0kcELtfaA"
}

extension APITarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.giphy.com") ?? URL(fileURLWithPath: "")
    }
    
    var path: String {
        switch self {
        case .search:
            return "/v1/gifs/searchn"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    var task: Parameters {
        switch self {
        case .search(let query):
            return ["api_key": query, "q": query, "limit": 25, "offset": 0, "rating": "g", "lang": "en"]
        }
    }
    
    var endPoint: URLRequest? {
        var request = URLRequest(url: URL(string: baseURL.absoluteString + path) ?? URL(fileURLWithPath: ""))
        request.httpMethod = method.rawValue
        return try? URLEncoding.queryString.encode(request, with: task)
    }
    
//    var headers: [String: String]? {
//        switch self {
//        case .search:
//            return
//        }
//    }
}
