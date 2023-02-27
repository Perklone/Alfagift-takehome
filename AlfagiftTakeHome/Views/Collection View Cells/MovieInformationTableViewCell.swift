//
//  MovieInformationCollectionViewCell.swift
//  AlfagiftTakeHome
//
//  Created by Rizky Maulana on 27/02/23.
//

import UIKit

class MovieInformationTableViewCell: UITableViewCell {
    static let identifier = "movie-detail-cell"
    
    var movieName = UILabel()
    var moviePoster = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        movieName.translatesAutoresizingMaskIntoConstraints = false
        moviePoster.translatesAutoresizingMaskIntoConstraints = false
        
        moviePoster.contentMode = .scaleAspectFit
        
        addSubview(movieName)
        addSubview(moviePoster)
        
        NSLayoutConstraint.activate([
            movieName.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            movieName.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            moviePoster.leadingAnchor.constraint(equalTo: movieName.trailingAnchor),
            moviePoster.topAnchor.constraint(equalTo: movieName.topAnchor),
            moviePoster.widthAnchor.constraint(equalToConstant: 45),
            movieName.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
