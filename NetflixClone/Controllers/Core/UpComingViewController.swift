//
//  UpComingViewController.swift
//  NetflixClone
//
//  Created by Madoo on 27/11/2022.
//

import UIKit

class UpComingViewController: UIViewController {
    
    var results = TrendingTitles()
    var titles = [mytitle]()
    var video = IdVideoElement()
    
    private let NetworkConnector = ConnectingViewModel()
    
    @IBOutlet weak var upComingTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        upComingTable.delegate = self
        upComingTable.dataSource = self
        gettingData()
    }
    
    
    func configure(with  results: TrendingTitles ){
        self.results = results
        self.titles = results.results!
        DispatchQueue.main.async { [weak self] in
            self?.upComingTable.reloadData()
        }
    }
    
    
    func gettingData(){
        NetworkConnector.passingData(with: MethodType.getUpComing) { data in
            self.configure(with: data)
        }
        }
    }


extension UpComingViewController:UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "upComingCell", for: indexPath) as! TitleTableViewCell
        
    guard let titleimage = titles[indexPath.row].poster_path else {return UITableViewCell()}
    guard let titlename = titles[indexPath.row].original_title else {return UITableViewCell()}
        
        cell.setImage(model: titleimage)
        cell.setlbl(model: titlename)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let Title = titles[indexPath.row]
        
        guard let titleName = Title.original_title ?? Title.original_name else{return}
        guard let overview = Title.overview else {return}
        
        NetworkConnector.passingVideoElement(with: titleName + " trailer ") { video in
            guard let id = video.items?[0].id else {return}
            DispatchQueue.main.async {
                let vc = TitlePreviewViewController()
                vc.configure(with: TitlePreviewModel(title: titleName, overview: overview, id: id))
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

