//
//  CollectionViewTableViewCell.swift
//  NetflixClone
//
//  Created by Madoo on 27/11/2022.
//

import UIKit
protocol CollectionViewTableViewCellDelegate : AnyObject{
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewModel)
}

class CollectionViewTableViewCell: UITableViewCell {
     var results = TrendingTitles()
    var titles = [mytitle]()
//    var youtubeResults = YoutubeResults()
//    var VideoElements = [VideoElement]()
//    var id = IdVideoElement()
    weak var delegate: CollectionViewTableViewCellDelegate?
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    public func configure(with results:TrendingTitles){
        self.results = results
        self.titles = results.results!
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
//    public func configureYoutube(with results: YoutubeResults){
//        self.youtubeResults = results
//        self.VideoElements = results.items!
//    }

}
extension CollectionViewTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        cell.setImage(model: titles[indexPath.row].poster_path!)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else {return}
        guard let titleOveriew = title.overview else {return}
        APIcaller.shared.getMovie(with: titleName + " trailer ") { response in
            guard let id = response.items?[0].id else{return}
            self.delegate?.collectionViewTableViewCellDidTapCell(self, viewModel: TitlePreviewModel(title: titleName, overview: titleOveriew, id: id))
        }
    }

}
