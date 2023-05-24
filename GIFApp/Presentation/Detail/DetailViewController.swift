//
//  DetailViewController.swift
//  GIFApp
//
//  Created by 김동현 on 2022/04/28.
//

import UIKit

class DetailViewController: UIViewController {
    private let gifImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bannerImageView, userLabel, favoriteButton])
        stackView.axis = .horizontal
        stackView.spacing = 5
        
        bannerImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.1).isActive = true
        userLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.4).isActive = true
        favoriteButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2).isActive = true
        
        return stackView
    }()
    
    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let userLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        let uiImage = viewModel.isFavorite(hashId: hashId) ? UIImage(named: "favorite") : UIImage(named: "unFavorite")
        button.setImage(uiImage, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.addTarget(self, action: #selector(didSetFavorite), for: .touchUpInside)
        return button
    }()
    
    private var viewModel: DefaultDetailViewModel
    private let hashId: String
    
    init(viewModel: DefaultDetailViewModel) {
        self.viewModel = viewModel
        hashId = viewModel.content.id ?? ""
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindViewModel()
    }
    
    private func setupViews() {
        view.addSubview(gifImageView)
        view.addSubview(stackView)
        
        gifImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gifImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            gifImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            gifImageView.widthAnchor.constraint(equalToConstant: view.bounds.width - 28),
            gifImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: gifImageView.bottomAnchor, constant: 14),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            stackView.widthAnchor.constraint(equalToConstant: view.bounds.width - 28),
            stackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func bindViewModel() {
        userLabel.text = viewModel.content.owner
        gifImageView.image = viewModel.content.convertedGif
        
        guard let bannerPath = viewModel.content.bannerPath, let bannerURL = URL(string: bannerPath) else { return }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: bannerURL) else { return }
            DispatchQueue.main.async { [weak self] in
                self?.bannerImageView.image = UIImage(data: data)
            }
        }
    }
    
    @objc func didSetFavorite() {
        if viewModel.isFavorite(hashId: hashId) {
            viewModel.removeFavorite(hashId: hashId)
            favoriteButton.setImage(UIImage(named: "unFavorite"), for: .normal)

        } else {
            viewModel.addFavorite(hashId: hashId)
            favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
        }
    }
}
