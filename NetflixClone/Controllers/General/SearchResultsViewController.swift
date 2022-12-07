//
//  SearchResultsViewController.swift
//  NetflixClone
//
//  Created by Madoo on 30/11/2022.
//

import UIKit
protocol CollectionViewCellDelegate: AnyObject{
    func DidTapCellforCollectionView(viewModel: TitlePreviewModel)
}

class SearchResultsViewController: UIViewController {
    
    public var results = TrendingTitles()
    public var titles = [mytitle]()
    private let NetworkConnector = ConnectingViewModel()
    weak var delegate: CollectionViewCellDelegate?
    
    public let searchcollectionViewResults: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchCollectionViewCell.self
                                , forCellWithReuseIdentifier: "\(SearchCollectionViewCell.identifier)")
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(searchcollectionViewResults)
        searchcollectionViewResults.delegate = self
        searchcollectionViewResults.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchcollectionViewResults.frame = view.bounds
    }
    func configure(with results:TrendingTitles){
        self.results = results
        self.titles = results.results!
    }
}
extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(SearchCollectionViewCell.identifier)", for: indexPath) as! SearchCollectionViewCell
        if titles[indexPath.row].poster_path != nil {
            cell.setImage(model: titles[indexPath.row].poster_path!)
        }
        else{
            print("Error")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        
        guard let titleName = title.original_title ?? title.original_name else {return}
        guard let titleOverview = title.overview else {return}
        
        NetworkConnector.passingVideoElement(with: titleName + " trailer ") { video in
            guard let id = video.items?[0].id else {return}
            
            self.delegate?.DidTapCellforCollectionView(viewModel: TitlePreviewModel(title: titleName, overview: titleOverview, id: id))
        }
    }
}

