//
//  SearchItemCell.swift
//  GIFApp
//
//  Created by 김동현 on 2022/04/27.
//

import UIKit

class SearchItemCell: UICollectionViewCell {
    
    // MARK: - private
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [gifImageView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    let gifImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var model: SearchItemCellModel?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gifImageView.image = nil
    }
    
    private func setupViews() {
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
            stackView.widthAnchor.constraint(equalToConstant: contentView.bounds.width - 28),
            stackView.heightAnchor.constraint(equalToConstant: contentView.bounds.height - 28)
        ])
    }
        
    private func setGifImage() {
        gifImageView.image = model?.gifImage
    }
}

extension SearchItemCell {
    func bind(_ model: SearchItemCellModel) {
        self.model = model
        setGifImage()
    }
}
