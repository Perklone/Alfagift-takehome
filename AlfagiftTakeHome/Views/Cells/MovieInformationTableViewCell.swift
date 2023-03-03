//
//  MovieInformationCollectionViewCell.swift
//  AlfagiftTakeHome
//
//  Created by Rizky Maulana on 27/02/23.
//

import UIKit

class MovieInformationTableViewCell: UITableViewCell {
    static let identifier = "movie-detail-cell"
    
    var movieNameLabel = UILabel()
    var movieReleaseLabel = UILabel()
    var moviePoster = CustomImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        movieNameLabel.font = .systemFont(ofSize: 32, weight: .bold)
        movieNameLabel.adjustsFontSizeToFitWidth = true
        movieNameLabel.minimumScaleFactor = 0.4
        movieNameLabel.numberOfLines = 2
        moviePoster.translatesAutoresizingMaskIntoConstraints = false
        
        movieReleaseLabel.translatesAutoresizingMaskIntoConstraints = false
        movieReleaseLabel.font = .systemFont(ofSize: 18, weight: .regular)
        movieReleaseLabel.adjustsFontSizeToFitWidth = true
        movieReleaseLabel.minimumScaleFactor = 0.4
        
//        moviePoster.image = UIImage(named: "poster")
        
        moviePoster.contentMode = .scaleAspectFit
        
        addSubview(movieNameLabel)
        addSubview(movieReleaseLabel)
        addSubview(moviePoster)
        
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(equalTo: topAnchor,constant: 15),
            movieNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            movieNameLabel.trailingAnchor.constraint(equalTo: moviePoster.leadingAnchor,constant: -8),
            
            movieReleaseLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor,constant: 3),
            movieReleaseLabel.leadingAnchor.constraint(equalTo: movieNameLabel.leadingAnchor),
            movieReleaseLabel.trailingAnchor.constraint(equalTo: movieNameLabel.trailingAnchor),
            
            moviePoster.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8),
            moviePoster.topAnchor.constraint(equalTo: movieNameLabel.topAnchor),
            moviePoster.widthAnchor.constraint(equalToConstant: 120),
            moviePoster.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    func setCell(with MovieName: String, posterPath: String, and releaseDate: String) {
        movieNameLabel.text = MovieName
        moviePoster.downloadImage(from: posterPath)
        movieReleaseLabel.text = releaseDate
    }
    
    
}
