//
//  API.swift
//  GIFApp
//
//  Created by 김동현 on 2022/04/27.
//

import Alamofire
import Foundation

class API {        
    static func search(query: String, completion: @escaping (Result<GifResponse>) -> Void) {
        let apiTarget = APITarget.search(query: query)
        Alamofire.request(apiTarget.apiURL, method: .get, parameters: apiTarget.task, encoding: URLEncoding.queryString).responseJSON() { response in
            switch response.result {
            case .success(_):
                guard let result = response.data, let content = try? JSONDecoder().decode(GifResponse.self, from: result) else {
                    fatalError()
                }
                completion(.success(content))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
