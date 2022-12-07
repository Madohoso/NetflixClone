//
//  BigHeaderUIView.swift
//  NetflixClone
//
//  Created by Madoo on 27/11/2022.
//

import UIKit
import SDWebImage

class BigHeaderUIView: UIView {
    private let DownloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let PlayButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let BigHeaderImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Wednesday")
        return imageView
        
    }()
    private func addGradient(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor , UIColor.systemBackground.cgColor]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    private func applyConstarints(){
        let playButtonConstraints = [
            PlayButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90),
            PlayButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            PlayButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        let DownloadButtonConstraints = [
            DownloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90),
            DownloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            DownloadButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(DownloadButtonConstraints)
    }
    public func configure(with model: mytitle){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.poster_path!)") else {return}
        BigHeaderImage.sd_setImage(with: url)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(BigHeaderImage)
        addGradient()
        addSubview(PlayButton)
        addSubview(DownloadButton)
        applyConstarints()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        BigHeaderImage.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}
