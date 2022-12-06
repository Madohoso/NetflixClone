//
//  SearchCollectionViewCell.swift
//  NetflixClone
//
//  Created by Madoo on 03/12/2022.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    static let identifier = "SearchCollectionViewCell"
    
    private let posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImage)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImage.frame = contentView.bounds
    }
    public func setImage(model:String){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model)") else{return}
        posterImage.sd_setImage(with: url)
    }
}
