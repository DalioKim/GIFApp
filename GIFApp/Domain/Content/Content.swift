//
//  Content.swift
//  GIFApp
//
//  Created by 김동현 on 2023/05/24.
//

import Foundation

protocol Content {
    var id: String? {
        get set
    }
    var path: String? {
        get set
    }
    var owner: String? {
        get set
    }
}
