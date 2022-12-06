//
//  madoViewController.swift
//  NetflixClone
//
//  Created by Madoo on 06/12/2022.
//

import UIKit

class madoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        APIhandler.shared.GenericAPIcalling(type: MethodType.getTrendingMovies) { (response: TrendingTitles) in
            print(response)
        }
    }
    
}
