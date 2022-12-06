//
//  SearchViewController.swift
//  NetflixClone
//
//  Created by Madoo on 27/11/2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    var results = TrendingTitles()
    var titles = [mytitle]()
    @IBOutlet weak var DiscoverTable: UITableView!
    
    private let SearchController:UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a movie"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        DiscoverTable.delegate = self
        DiscoverTable.dataSource = self
        navigationItem.searchController = SearchController
        navigationController?.navigationBar.tintColor = .white
        DiscoverMovies()
        SearchController.searchResultsUpdater = self
    }
    
    
    func configure(with results:TrendingTitles){
        self.results = results
        self.titles = results.results!
        DispatchQueue.main.async { [weak self] in
            self?.DiscoverTable.reloadData()
        }
    }
    
    
    func DiscoverMovies(){
        APIcaller.shared.getDiscoverMovies { response in
            self.configure(with: response)
        }
    }
    
}


extension SearchViewController:UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscoverCell", for: indexPath) as! TitleTableViewCell
        cell.setImage(model: titles[indexPath.row].poster_path!)
        cell.setlbl(model: titles[indexPath.row].original_title!)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
extension SearchViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchbar = searchController.searchBar
        guard let query = searchbar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultscontroller = searchController.searchResultsController as? SearchResultsViewController else {
            return
        }
        APIcaller.shared.searchForitem(with: query) { response in
            resultscontroller.results = response
            resultscontroller.titles = resultscontroller.results.results!
            DispatchQueue.main.async {
                resultscontroller.searchcollectionViewResults.reloadData()
            }
                }
            }
        }
