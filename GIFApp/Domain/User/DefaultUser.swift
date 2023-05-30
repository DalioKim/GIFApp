//
//  GeneralUser.swift
//  GIFApp
//
//  Created by 김동현 on 2023/05/29.
//

import Foundation

struct DefaultUser: User {
    var cach: Int
    var ownedList: [String]
    var OrderRecords: [ImageOrder]
    var nickName: String?
    var email: String?
}
