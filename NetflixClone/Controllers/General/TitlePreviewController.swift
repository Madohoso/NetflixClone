//
//  TitlePreviewController.swift
//  NetflixClone
//
//  Created by Madoo on 04/12/2022.
//

import UIKit
import WebKit

class TitlePreviewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var titlelbl: UILabel!
    
    @IBOutlet weak var downloadbtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
