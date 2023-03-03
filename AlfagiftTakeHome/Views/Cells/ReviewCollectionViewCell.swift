//
//  ReviewCollectionViewCell.swift
//  AlfagiftTakeHome
//
//  Created by Rizky Maulana on 28/02/23.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
    static let identifier = "reviewlist-collection-view"
    
    let authorLabel = UILabel()
    let contentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .green
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.textAlignment = .center
        authorLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.textAlignment = .center
        contentLabel.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        
        addSubview(authorLabel)
        addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8),
            
            contentLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor,constant: 6),
            contentLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor)
        ])
    }
    
    func setupLabel(author: String, content: String) {
        authorLabel.text = author
        contentLabel.text = content
    }
}
