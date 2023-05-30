//
//  Records.swift
//  GIFApp
//
//  Created by 김동현 on 2023/05/30.
//

import Foundation

protocol Order {
    var uid: Int {
        get set
    }
    var userId: String {
        get set
    }
    var orderTime: Date {
        get set
    }
    var orderStatus: String {
        get set
    }
}
