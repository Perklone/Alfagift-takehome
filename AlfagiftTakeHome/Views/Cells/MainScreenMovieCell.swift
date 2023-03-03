//
//  HomeCategoriesCell.swift
//  AlfagiftTakeHome
//
//  Created by Rizky Maulana on 26/02/23.
//

import UIKit

class MainScreenMovieCell: UICollectionViewCell {
    
    static let identifier = "MainMovieCell"
    
    var posterImageView = CustomImageView()
    var categoryNameLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.categoryNameLabel.text = ""
        self.posterImageView.image = UIImage(named: "NoPoster")
    }
    
    private func configure() {
        layer.cornerRadius = 8
        
        categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryNameLabel.font = .preferredFont(forTextStyle: .headline)
        categoryNameLabel.adjustsFontForContentSizeCategory = true
        categoryNameLabel.adjustsFontSizeToFitWidth = true
        categoryNameLabel.minimumScaleFactor = 0.6
        categoryNameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        categoryNameLabel.numberOfLines = 2
        categoryNameLabel.text = ""
        categoryNameLabel.textAlignment = .center
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 8
        posterImageView.contentMode = .scaleToFill
        posterImageView.alpha = 0.8
        posterImageView.image = UIImage(named: "NoPoster")
        
        addSubview(posterImageView)
        addSubview(categoryNameLabel)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 225),
            
//            categoryNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            categoryNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            categoryNameLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor,constant: 10),
        ])
    }
    
    func updateCell(with title:String, and imagePath: String) {
        categoryNameLabel.text = title
        posterImageView.downloadImage(from: imagePath)
    }
}
