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
    @IBOutlet weak var upComingTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        upComingTable.delegate = self
        upComingTable.dataSource = self
        fetchData()
    }
    func configure(with  results: TrendingTitles ){
        self.results = results
        self.titles = results.results!
        DispatchQueue.main.async { [weak self] in
            self?.upComingTable.reloadData()
        }
    }
    func fetchData(){
        APIcaller.shared.getUpComing { response in
            self.configure(with: response)
        }
    }
}
extension UpComingViewController:UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "upComingCell", for: indexPath) as! TitleTableViewCell
        cell.setImage(model: titles[indexPath.row].poster_path!)
        cell.setlbl(model: titles[indexPath.row].original_title!)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}
