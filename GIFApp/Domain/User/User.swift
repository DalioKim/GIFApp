//
//  Member.swift
//  GIFApp
//
//  Created by 김동현 on 2023/05/29.
//

import Foundation

protocol User {
    var nickName: String? {
        get set
    }
    var email: String? {
        get set
    }
    var cach: Int {
        get set
    }
    var ownedList: [String] {
        get set
    }
    var OrderRecords: [ImageOrder] {
        get set
    }
}
