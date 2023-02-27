//
//  ViewController.swift
//  AlfagiftTakeHome
//
//  Created by Rizky Maulana on 26/02/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    var array: [Movie] = []
    var pageIndex = 1
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialView()
        configureCollectionView()
        getMovieList(page: pageIndex)
    }
    
    private func configureInitialView() {
        title = "Alfagift Movie"
        view.backgroundColor = .systemBackground
    }
    
    private func configureCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
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
        NetworkManager.shared.getPopularMovies(page: index, completion: { response in
            self.array.append(contentsOf: response.results)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let title = array[indexPath.row].title
        let posterPath = array[indexPath.row].posterPath
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenMovieCell.identifier, for: indexPath) as! MainScreenMovieCell
        cell.tag = indexPath.row
        
        cell.updateCell(with: title, and: posterPath)
        cell.backgroundColor = .systemFill
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailVC = MovieDetailViewController(movieID: array[indexPath.row].id)
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for path in indexPaths {
            NetworkManager.shared.downloadImage(from: array[path.row].posterPath, completed: nil)
        }
        print("Prefetch \(indexPaths)")
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 19
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = view.bounds.width
        let padding = 20
        let width = Int(availableWidth) - (padding*2)
        
        return CGSize(width: width, height: Int(view.bounds.height)/2)
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
