//
//  NSObject+ClassName.swift
//  GIFApp
//
//  Created by 김동현 on 2022/04/27.
//


import Foundation

@objc
extension NSObject {
    class var className: String {
        String(describing: self)
    }
}
