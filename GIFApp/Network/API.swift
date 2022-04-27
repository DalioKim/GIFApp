//
//  API.swift
//  GIFApp
//
//  Created by 김동현 on 2022/04/27.
//

import Alamofire

class API {
    static private let baseURL = "https://api.giphy.com/v1/gifs/search?"
    
    static func search() {
        let param: Parameters = ["api_key": "cq4rncLej0srZAZYS8yP3o28AyEHiK7f", "q": "war", "limit": 4]
        
        Alamofire.request(baseURL, method: .get, parameters: param, encoding: URLEncoding.queryString).responseJSON() { response in
            switch response.result {
            case .success(let data):
                let result = response.data!
                let test = try? JSONDecoder().decode(GifResponse.self, from: response.data!)
                print("네트워크 test\(test)")
                break
            case .failure(let error):
                print("네트워크: 실패 \(error)")
                break
            }
        }
    }
}
