//
//  DetailViewModel.swift
//  GIFApp
//
//  Created by 김동현 on 2022/04/28.
//

class DetailViewModel {
    private let model: SearchItemCellModel?
    
    init(model: SearchItemCellModel?) {
        self.model = model
    }
}

extension DetailViewModel {
    var path: String? {
        model?.path
    }
    
    var hash: String? {
        model?.hash
    }
    
    var bannerURL: String? {
        model?.bannerURL
    }
    
    var userName: String? {
        model?.userName
    }
}
