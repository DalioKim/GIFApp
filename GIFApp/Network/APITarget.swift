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
    var apiURL: URL { get }
    var method: HTTPMethod { get }
    var task: Parameters { get }
}

enum APITarget {
    case search(query: String)
}

extension APITarget {
    static private let clientKey = "cq4rncLej0srZAZYS8yP3o28AyEHiK7f"
}

extension APITarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.giphy.com") ?? URL(fileURLWithPath: "")
    }
    
    var path: String {
        switch self {
        case .search:
            return "/v1/gifs/search"
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
            return ["api_key": APITarget.clientKey, "q": query, "limit": 4]
        }
    }
    
    var apiURL: URL {
        return URL(string: baseURL.absoluteString + path) ?? URL(fileURLWithPath: "")
    }
}
