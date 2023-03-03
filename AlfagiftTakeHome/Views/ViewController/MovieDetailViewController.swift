//
//  MovieDetailViewController.swift
//  AlfagiftTakeHome
//
//  Created by Rizky Maulana on 27/02/23.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movieID: Int!
    var movieInformation: MovieDetail?
    let tableView = UITableView()
    var backgroundImage: UIImage? = UIImage(named: "NoPoster")
    var movieReview: ReviewResponse? = nil
    
    init(movieID: Int) {
        super.init(nibName: nil, bundle: nil)
        self.movieID = movieID
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        getMovieDetail()
    }
    
    private func getMovieDetail() {
        NetworkManager.shared.getMovieDetail(with: movieID, and: [.reviews,.videos]) { movieDetail in
            self.movieInformation = movieDetail
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    private func configure() {
        title = movieInformation?.title        
        view.backgroundColor = .systemBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableViewCellRegistration()
        view.addSubview(tableView)
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}

extension MovieDetailViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieBackgroundTableViewCell.identifier,for: indexPath) as! MovieBackgroundTableViewCell
            let imagePath = movieInformation?.backdropPath
            cell.backgroundImage.downloadImage(from: imagePath ?? "none")
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieInformationTableViewCell.identifier, for: indexPath) as! MovieInformationTableViewCell
            let movieName = movieInformation?.title ?? "Unknown"
            let releaseDate = "Released in \(movieInformation?.releaseDate.convertToFormattedDate() ?? "Unknown")"
            let imagePath = movieInformation?.posterPath ?? "none"
            cell.setCell(with: movieName, posterPath: imagePath, and: releaseDate)
            
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieTrailerTableViewCell.identifier, for: indexPath) as! MovieTrailerTableViewCell
            cell.contentView.isUserInteractionEnabled = false
            cell.playerView.load(withVideoId: movieInformation?.videos.results[0].key ?? "dQw4w9WgXcQ",playerVars: ["playsinline" : 1])
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.identifier,for: indexPath) as! EmptyTableViewCell
            cell.setupDescription(with: .NoReview)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 170
        }
        else if indexPath.row == 1 {
            return 190
        } else {
            return 300
        }
    }
}

extension MovieDetailViewController {
    func tableViewCellRegistration() {
        tableView.register(MovieInformationTableViewCell.self, forCellReuseIdentifier: MovieInformationTableViewCell.identifier)
        tableView.register(MovieBackgroundTableViewCell.self, forCellReuseIdentifier: MovieBackgroundTableViewCell.identifier)
        tableView.register(MovieTrailerTableViewCell.self, forCellReuseIdentifier: MovieTrailerTableViewCell.identifier)
        tableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: EmptyTableViewCell.identifier)
    }
}
