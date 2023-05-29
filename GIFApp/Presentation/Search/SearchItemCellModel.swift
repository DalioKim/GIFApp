//
//  SearchItemCellModel.swift
//  GIFApp
//
//  Created by 김동현 on 2022/04/27.
//

import UIKit

class SearchItemCellModel {
    let content: GIFItem?
    private weak var parentViewModel: DefaultSearchViewModel?
    
    init(parentViewModel: DefaultSearchViewModel?, item: GifResponse.ImageData?) {
        self.parentViewModel = parentViewModel
        self.content = GIFItem(item)
    }
}

extension SearchItemCellModel {
    var gifImage: UIImage? {
        content?.convertedGif
    }
    
    var id: String? {
        content?.id
    }
    
    var bannerURL: String? {
        content?.bannerPath
    }

    var owner: String? {
        content?.owner
    }
}
