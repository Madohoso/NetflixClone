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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else {return}
        guard let titleOverview = title.overview else {return}
        APIcaller.shared.getMovie(with: titleName + " trailer ") { response in
            guard let id = response.items?[0].id else{return}
            DispatchQueue.main.async {
                let vc = TitlePreviewViewController()
                vc.configure(with: TitlePreviewModel(title: titleName, overview: titleOverview, id: id))
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
extension SearchViewController:UISearchResultsUpdating, CollectionViewCellDelegate{
   
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchbar = searchController.searchBar
        guard let query = searchbar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultscontroller = searchController.searchResultsController as? SearchResultsViewController else {
            return
        }
        resultscontroller.delegate = self
        APIcaller.shared.searchForitem(with: query) { response in
            resultscontroller.results = response
            resultscontroller.titles = resultscontroller.results.results!
            DispatchQueue.main.async {
                resultscontroller.searchcollectionViewResults.reloadData()
            }
                }
       
            }
    func DidTapCellforCollectionView(viewModel: TitlePreviewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
        }

