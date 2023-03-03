//
//  MovieTrailerTableViewCell.swift
//  AlfagiftTakeHome
//
//  Created by Rizky Maulana on 28/02/23.
//

import youtube_ios_player_helper
import UIKit

class MovieTrailerTableViewCell: UITableViewCell {
    static let identifier = "movie-trailer-cell"
    var playerView = YTPlayerView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.delegate = self
        addSubview(playerView)
        
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: topAnchor),
            playerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            playerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
extension MovieTrailerTableViewCell: YTPlayerViewDelegate {
    
}
