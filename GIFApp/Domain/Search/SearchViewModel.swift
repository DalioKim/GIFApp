//
//  SearchViewModel.swift
//  GIFApp
//
//  Created by 김동현 on 2022/04/27.
//

import Foundation

protocol SearchViewModelInput {
    func loadMore()
    func refresh()
    func search(_ query: String)
    func didSelect(at indexPath: IndexPath)
}

protocol SearchViewModelOutput {
    associatedtype ViewAction
    var cellModels: [SearchItemCellModel] { get set }
}

protocol SearchViewModel: SearchViewModelInput, SearchViewModelOutput {}

protocol SearchViewModelDelegate: AnyObject {
    func didLoadData()
    func didSelectItem(_ ViewAction: DefaultSearchViewModel.ViewAction)
}

final class DefaultSearchViewModel: SearchViewModel {
    typealias ViewAction = DefaultMovieListViewAction
    weak var delegate: SearchViewModelDelegate?
    var cellModels: [SearchItemCellModel] = []
    
    enum DefaultMovieListViewAction {
        case popViewController
        case showDetail(model: SearchItemCellModel)
    }
    
    // MARK: - paging
    
    // MARK: - Init
    
    init() {}
}

// MARK: - INPUT. View event methods

extension DefaultSearchViewModel {
    func loadMore() {}
    
    func refresh() {}
    
    func didSelect(at indexPath: IndexPath) {
        delegate?.didSelectItem(ViewAction.showDetail(model: cellModels[indexPath.item]))
    }
    
    func search(_ query: String) {
        API.search(query: query) { [weak self] result in
            switch result {
            case .success(let result):
                let list = result.data.map {
                    SearchItemCellModel(parentViewModel: self, model: $0.images)
                }
                list.map {
                    self?.cellModels.append($0)
                }
                self?.delegate?.didLoadData()
            case .failure(_):
                break
            }
        }
    }
}
