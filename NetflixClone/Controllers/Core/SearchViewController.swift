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
    
    private let NetworkConnector = ConnectingViewModel()
    
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
        gettingData()
        SearchController.searchResultsUpdater = self
    }
    
    
    func configure(with results:TrendingTitles){
        
        self.results = results
        self.titles = results.results!
        
        DispatchQueue.main.async { [weak self] in
            self?.DiscoverTable.reloadData()
        }
    }
    func gettingData(){
        NetworkConnector.passingData(with: MethodType.getDiscoverMovies) { data in
            self.configure(with: data)
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
       
        guard let titleName = title.original_title ?? title.original_name else{return}
        guard let overview = title.overview else {return}
        
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
        
        NetworkConnector.passingSearchResults(with: query) { data in
            resultscontroller.configure(with: data)
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

