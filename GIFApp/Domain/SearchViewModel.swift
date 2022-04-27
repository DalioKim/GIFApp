//
//  SearchViewModel.swift
//  GIFApp
//
//  Created by 김동현 on 2022/04/27.
//


protocol SearchViewModelInput {
    func loadMore()
    func refresh()
    func search(_ query: String)
}

protocol SearchViewModelOutput {
    associatedtype ViewAction
    var cellModels: [SearchItemCellModel] { get set }
}

protocol SearchViewModel: SearchViewModelInput, SearchViewModelOutput {}

protocol SearchViewModelDelegate: AnyObject {
    func didLoadData()
}

final class DefaultSearchViewModel: SearchViewModel {
    typealias ViewAction = DefaultMovieListViewAction
    weak var delegate: SearchViewModelDelegate?
    var cellModels: [SearchItemCellModel] = []
    
    enum DefaultMovieListViewAction {
        case popViewController
        case showDetail
    }
    
    // MARK: - paging
    
    // MARK: - Init
    
    init() {}
}

// MARK: - INPUT. View event methods

extension DefaultSearchViewModel {
    func loadMore() {}
    
    func refresh() {}
    
    func search(_ query: String) {
        API.search(query: query) { [weak self] result in
            switch result {
            case .success(let result):
                result.data.forEach {
                    self?.cellModels.append(SearchItemCellModel(parentViewModel: self, model: $0.images))
                }
                self?.delegate?.didLoadData()
            case .failure(_):
                break
            }
        }
    }
}
