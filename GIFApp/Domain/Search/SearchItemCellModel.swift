//
//  SearchItemCellModel.swift
//  GIFApp
//
//  Created by κΉλν on 2022/04/27.
//

class SearchItemCellModel {
    typealias Content = GifResponse.ImageData
    private let model: Content?
    private weak var parentViewModel: DefaultSearchViewModel?
    
    init(parentViewModel: DefaultSearchViewModel?, model: Content?) {
        self.parentViewModel = parentViewModel
        self.model = model
    }
}

extension SearchItemCellModel {
    var path: String? {
        model?.images?.original?.url
    }
    
    var hash: String? {
        model?.images?.original?.hash
    }
    
    var bannerURL: String? {
        model?.user?.bannerURL
    }

    var userName: String? {
        model?.user?.userName
    }
}
