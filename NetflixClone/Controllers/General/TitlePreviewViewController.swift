//
//  TitlePreviewViewController.swift
//  NetflixClone
//
//  Created by Madoo on 04/12/2022.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {

    private let Titlelabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Mado"
        return label
    }()
    private let Downloadbutton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    private let WebView: WKWebView = {
        let webview = WKWebView()
        webview.translatesAutoresizingMaskIntoConstraints = false
        return webview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(WebView)
        configureWebViewConstraints()
        view.addSubview(Titlelabel)
        view.addSubview(Downloadbutton)
        configureConstraints()
        navigationController?.navigationBar.tintColor = .white
    }
    func configureWebViewConstraints(){
        let webViewConstraints = [
            WebView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            WebView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            WebView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            WebView.heightAnchor.constraint(equalToConstant: 250)
        ]
        NSLayoutConstraint.activate(webViewConstraints)
    }
    func configureConstraints(){
        let titleLabelConstraints = [
            Titlelabel.topAnchor.constraint(equalTo: WebView.bottomAnchor, constant: 50),
            Titlelabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        let downloadButtonConstraints = [
            Downloadbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            Downloadbutton.topAnchor.constraint(equalTo: Titlelabel.topAnchor, constant: 50),
            Downloadbutton.widthAnchor.constraint(equalToConstant: 140),
            Downloadbutton.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    func configure(with model: TitlePreviewModel){
        Titlelabel.text = model.title! + " trailer "
        
        let url = URL(string: "https://www.youtube.com/embed/\(model.id!.videoId!)")
        print(url!)
        WebView.load(URLRequest(url:url!))
    }
}
