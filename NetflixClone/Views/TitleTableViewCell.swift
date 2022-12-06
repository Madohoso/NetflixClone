//
//  UpComingTableViewCell.swift
//  NetflixClone
//
//  Created by Madoo on 29/11/2022.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    var titles = [mytitle]()
    
    @IBOutlet weak var titleImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var plybtn: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setImage(model:String){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model)") else{return}
        titleImg.sd_setImage(with: url)
            }
    func setlbl(model:String){
        titlelbl.text = model
    }

}
