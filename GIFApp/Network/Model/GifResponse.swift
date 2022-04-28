
//  GifResponse.swift
//  GIFApp
//
//  Created by 김동현 on 2022/04/27.
//

import Foundation

struct GifResponse: Decodable {
    let data: [ImageData]
    
    enum Keys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        data = try container.decodeIfPresent([ImageData].self, forKey: .data) ?? []
    }
    
    struct ImageData: Decodable {
        let images: Image?
        let user: User?

        enum Keys: String, CodingKey {
            case images
            case user
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Keys.self)
            images = try container.decodeIfPresent(Image.self, forKey: .images)
            user = try container.decodeIfPresent(User.self, forKey: .user)
        }
        
        struct Image: Decodable {
            let original: Original?
            
            enum Keys: String, CodingKey {
                case original
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: Keys.self)
                original = try container.decodeIfPresent(Original.self, forKey: .original)
            }
            
            struct Original: Decodable {
                let url: String?
                let hash: String?

                enum Keys: String, CodingKey {
                    case url
                    case hash
                }
                
                init(from decoder: Decoder) throws {
                    let container = try decoder.container(keyedBy: Keys.self)
                    url = try container.decodeIfPresent(String.self, forKey: .url)
                    hash = try container.decodeIfPresent(String.self, forKey: .hash)
                }
            }
        }
        
        struct User: Decodable {
            let bannerURL: String?
            let userName: String?
            
            enum Keys: String, CodingKey {
                case banner_url
                case username
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: Keys.self)
                bannerURL = try container.decodeIfPresent(String.self, forKey: .banner_url)
                userName = try container.decodeIfPresent(String.self, forKey: .username)
            }
        }
    }
}
