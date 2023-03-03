//
//  EmptyTableViewCell.swift
//  AlfagiftTakeHome
//
//  Created by Rizky Maulana on 03/03/23.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {
    
    enum emptyType {
        case NoReview
    }
    
    static let identifier = "empty-tableview-cell"
    
    let posterImageView = UIImageView()
    let descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func configure() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.image = UIImage(named: "noReview")
        posterImageView.clipsToBounds = true
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        addSubview(posterImageView)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            posterImageView.widthAnchor.constraint(equalToConstant: 250),
            posterImageView.heightAnchor.constraint(equalToConstant: 200),
            posterImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            posterImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor,constant: 10),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setupDescription(with type: emptyType) {
        if type == .NoReview {
            descriptionLabel.text = "Currently there are no review."
        }
    }
}
