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
    
    private var viewModel: DetailViewModel

    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
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
        
        gifImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gifImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            gifImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            gifImageView.widthAnchor.constraint(equalToConstant: view.bounds.width - 28),
            gifImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func bindViewModel() {
        guard let path = viewModel.path else { return }
        gifImageView.image = UIImage().gifImageWithURL(gifUrl: path)
    }
}
