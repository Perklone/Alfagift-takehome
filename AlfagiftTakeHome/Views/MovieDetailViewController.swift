//
//  MovieDetailViewController.swift
//  AlfagiftTakeHome
//
//  Created by Rizky Maulana on 27/02/23.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movieID: Int!
    let tableView = UITableView()
    var movieName = ""
    var moviePoster: UIImage? = nil
    
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
            DispatchQueue.main.async {
                self.configureUIElements(with: movieDetail)
                self.getImage(with: movieDetail)
            }
        }
        
    }
    
    private func getImage(with detail: MovieDetail) {
        NetworkManager.shared.downloadImage(from: detail.posterPath) { image in
            self.moviePoster = image
            self.tableView.reloadData()
        }
    }
    
    private func configureUIElements(with detail: MovieDetail) {
        movieName = detail.title
        tableView.reloadData()
    }
    
    private func configure() {
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

extension MovieDetailViewController: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieInformationTableViewCell.identifier, for: indexPath) as! MovieInformationTableViewCell
        cell.movieName.text = movieName
        cell.moviePoster.image = moviePoster ?? UIImage(systemName: "check")
        return cell
    }
    
   
}

extension MovieDetailViewController {
    func tableViewCellRegistration() {
        tableView.register(MovieInformationTableViewCell.self, forCellReuseIdentifier: MovieInformationTableViewCell.identifier)
    }
}
