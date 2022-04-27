//
//  SearchItemCellModel.swift
//  GIFApp
//
//  Created by 김동현 on 2022/04/27.
//

class SearchItemCellModel {
    typealias Content = GifResponse.ImageData.Image
    private let model: Content?
    private weak var parentViewModel: DefaultSearchViewModel?
    
    init(parentViewModel: DefaultSearchViewModel?, model: Content?) {
        self.parentViewModel = parentViewModel
        self.model = model
    }
}

extension SearchItemCellModel {
    var path: String? {
        model?.original?.url
    }
}
