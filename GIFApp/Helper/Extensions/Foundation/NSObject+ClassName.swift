//
//  NSObject+ClassName.swift
//  GIFApp
//
//  Created by κΉλν on 2022/04/27.
//


import Foundation

@objc
extension NSObject {
    class var className: String {
        String(describing: self)
    }
}
