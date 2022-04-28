//
//  SearchViewController.swift
//  GIFApp
//
//  Created by 김동현 on 2022/04/27.
//

import UIKit

class SearchViewController: UIViewController {
    private let searchBar = UISearchBar()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout())
        collectionView.register(SearchItemCell.self, forCellWithReuseIdentifier: SearchItemCell.className)
        return collectionView
    }()
    
    private var viewModel: DefaultSearchViewModel
    
    // MARK: - Init
    
    init(viewModel: DefaultSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindSearchBar()
        bindViewModel()
    }
    
    private func setupViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            searchBar.widthAnchor.constraint(equalToConstant: view.bounds.width - 28),
            searchBar.heightAnchor.constraint(equalToConstant: 30)
        ])
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 14),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            collectionView.widthAnchor.constraint(equalToConstant: view.bounds.width - 28),
            collectionView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func bindSearchBar() {
        searchBar.delegate = self
        searchBar.sizeToFit()
    }
    
    private func bindViewModel() {
        self.viewModel.delegate = self
    }
    
    func compositionalLayout() -> UICollectionViewLayout {
        let mainItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/2),
                heightDimension: .fractionalHeight(1.0)))
        
        mainItem.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2)
        
        let pairItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)))
        
        pairItem.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2)
        
        let trailingGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/2),
                heightDimension: .fractionalHeight(1.0)),
            subitem: pairItem,
            count: 2)
        
        let mainGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(1/2)),
            subitems: [mainItem, trailingGroup])
        
        let mainReversedGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(1/2)),
            subitems: [trailingGroup, mainItem])
        
        let nestedGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(2/1)),
            subitems: [
                mainGroup,
                mainReversedGroup
            ]
        )
        
        let section = NSCollectionLayoutSection(group: nestedGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        viewModel.search(searchText)
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func didLoadData() {
        collectionView.reloadData()
    }
    
    func didSelectItem(_ ViewAction: DefaultSearchViewModel.ViewAction) {
        switch ViewAction {
        case .showDetail(let model):
            self.navigationController?.pushViewController(DetailViewController(viewModel: DefaultDetailViewModel(model: model)), animated: false)
        case.popViewController:
            break
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchItemCell.className, for: indexPath) as? SearchItemCell else { fatalError() }
        cell.bind(viewModel.cellModels[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchItemCell.className, for: indexPath) as? SearchItemCell else { fatalError() }
        cell.gifImageView.image = nil
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelect(at: indexPath)
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}
