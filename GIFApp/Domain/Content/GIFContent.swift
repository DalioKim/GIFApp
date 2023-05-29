//
//  GIFContent.swift
//  GIFApp
//
//  Created by 김동현 on 2023/05/29.
//

import Foundation
import UIKit

protocol GIFContent: Content {
    var id: String? {
        get set
    }
    
    var path: String? {
        get set
    }
    
    var owner: String? {
        get set
    }
    
    var convertedGif: UIImage? {
        get
    }
}
