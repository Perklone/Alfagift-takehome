//
//  MovieReviewTableViewCell.swift
//  AlfagiftTakeHome
//
//  Created by Rizky Maulana on 28/02/23.
//

import UIKit

class MovieReviewTableViewCell: UITableViewCell {
    static let identifier = "MovieReview-Tableview-Cell"
    
    var reviewList: [Review] = []

    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: ReviewCollectionViewCell.identifier)
        
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -5),
            collectionView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    func getReviewList(_ value :[Review]) {
        reviewList.append(contentsOf: value)
        print(reviewList.count)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension MovieReviewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.identifier, for: indexPath) as! ReviewCollectionViewCell
        
//        cell.setupLabel(author: reviewList[indexPath.row].author, content: reviewList[indexPath.row].content)
        return cell
    }
    
    
}
