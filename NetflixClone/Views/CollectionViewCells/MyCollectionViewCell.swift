//
//  MyCollectionViewCell.swift
//  NetflixClone
//
//  Created by Madoo on 29/11/2022.
//

import UIKit
import SDWebImage
class MyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    
    func setImage(model:String){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model)") else{return}
        posterImage.sd_setImage(with: url)
    }
}
