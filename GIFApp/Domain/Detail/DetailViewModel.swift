//
//  DetailViewModel.swift
//  GIFApp
//
//  Created by 김동현 on 2022/04/28.
//

import Foundation

protocol DetailViewModelInput {
    func addFavorite(hashId: String)
    func removeFavorite(hashId: String)
}

protocol DetailViewModelOutput {
    func isFavorite(hashId: String) -> Bool
}

protocol DetailViewModel: DetailViewModelInput, DetailViewModelOutput {}


class DefaultDetailViewModel: DetailViewModel {
    private let model: SearchItemCellModel?
    
    init(model: SearchItemCellModel?) {
        self.model = model
    }
}

extension DefaultDetailViewModel {
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

extension DefaultDetailViewModel {
    func addFavorite(hashId: String) {
        var FavoriteList = UserDefaults.standard.stringArray(forKey: "FavoriteList") ?? [String]()
        FavoriteList.append(hashId)
        UserDefaults.standard.set(FavoriteList, forKey: "FavoriteList")
    }
    
    func removeFavorite(hashId: String) {
        var FavoriteList = UserDefaults.standard.stringArray(forKey: "FavoriteList") ?? [String]()
        FavoriteList = FavoriteList.filter() {
            $0 != hashId
        }
        UserDefaults.standard.set(FavoriteList, forKey: "FavoriteList")
    }

    func isFavorite(hashId: String) -> Bool {
        guard let FavoriteList = UserDefaults.standard.stringArray(forKey: "FavoriteList") else { return false }
        return FavoriteList.contains(hashId)
    }
}
