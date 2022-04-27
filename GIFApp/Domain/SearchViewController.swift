//
//  SearchViewController.swift
//  GIFApp
//
//  Created by 김동현 on 2022/04/27.
//

import UIKit

class SearchViewController: UIViewController {
    private let searchBar = UISearchBar()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        viewModel.search(searchText)
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func didLoadData() {
        print("debug: \(self.viewModel.cellModels)")
        collectionView.reloadData()
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
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}
