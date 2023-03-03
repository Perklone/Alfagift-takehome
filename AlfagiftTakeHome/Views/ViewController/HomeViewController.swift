//
//  ViewController.swift
//  AlfagiftTakeHome
//
//  Created by Rizky Maulana on 26/02/23.
//

import UIKit

class HomeViewController: LoadingProgressViewController {
    
    var array: [Movie] = []
    var pageIndex = 1
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialView()
        configureCollectionView()
        getMovieList(page: pageIndex)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func configureInitialView() {
        title = "Alfagift Movie"
        view.backgroundColor = .systemBackground
        navigationItem.backButtonTitle = ""
    }
    
    private func configureCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.isPrefetchingEnabled = true
        
        collectionView.register(MainScreenMovieCell.self, forCellWithReuseIdentifier: MainScreenMovieCell.identifier)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func getMovieList(page index: Int) {
        showLoadingView()
        NetworkManager.shared.getPopularMovies(page: index, completion: { response in
            self.array.append(contentsOf: response.results)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.dismissLoadingView()
            }
        })
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let title = array[indexPath.row].title
        let posterPath = array[indexPath.row].posterPath
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenMovieCell.identifier, for: indexPath) as! MainScreenMovieCell
        cell.updateCell(with: title, and: posterPath)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailVC = MovieDetailViewController(movieID: array[indexPath.row].id)
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 19
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = view.bounds.width
        let padding = 12
        let spacingBetweenCell = 10
        var availableSpace = Int(availableWidth) - padding*2 - spacingBetweenCell
        availableSpace = availableSpace / 2
        
        return CGSize(width: availableSpace, height: Int(275))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 12)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        if offsetY > contentHeight - height {
            pageIndex+=1
            getMovieList(page: pageIndex)
        }
    }
}
