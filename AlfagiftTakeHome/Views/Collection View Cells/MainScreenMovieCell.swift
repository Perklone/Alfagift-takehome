//
//  HomeCategoriesCell.swift
//  AlfagiftTakeHome
//
//  Created by Rizky Maulana on 26/02/23.
//

import UIKit

class MainScreenMovieCell: UICollectionViewCell {
    
    static let identifier = "MainMovieCell"
    
    var posterImageView = UIImageView()
    var categoryNameLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func prepareForReuse() {
//        self.categoryNameLabel.text = ""
//        self.posterImageView.image = nil
//        
//        super.prepareForReuse()
//    }
    
    private func configure() {
        layer.cornerRadius = 8
        
        categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryNameLabel.font = .preferredFont(forTextStyle: .headline)
        categoryNameLabel.adjustsFontForContentSizeCategory = true
        categoryNameLabel.adjustsFontSizeToFitWidth = true
        categoryNameLabel.minimumScaleFactor = 0.6
        categoryNameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        categoryNameLabel.numberOfLines = 2
        categoryNameLabel.textColor = .white
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 8
        posterImageView.alpha = 0.8
        
        addSubview(posterImageView)
        addSubview(categoryNameLabel)
        
        NSLayoutConstraint.activate([
//            categoryNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            categoryNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20),
            categoryNameLabel.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func updateCell(with title:String, and imagePath: String) {
        categoryNameLabel.text = title
        NetworkManager.shared.downloadImage(from: imagePath) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.posterImageView.image = image
            }
        }
    }
}
