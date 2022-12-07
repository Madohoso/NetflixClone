//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by Madoo on 27/11/2022.
//

import UIKit

enum Sections: Int{
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}





class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeFeedTable: UITableView!
    
    
    let sectionTitles:[String] = ["Trending Movies","Trending Tv","Popular", "Upcoming Movies", "Top rated"]
    var results: TrendingTitles?
    var Title: [mytitle]?
    var headerView: BigHeaderUIView?
    private let NetworkConnector = ConnectingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        NavConfigure()
        headerView = BigHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        navigationItem.backButtonTitle = " "
        configureBigHeader()
        
    }
   
    func configureBigHeader(){
        
        NetworkConnector.passingData(with: MethodType.getTrendingMovies) { data in
            self.configurewithData(with: data)
            let randomtitle = self.Title?.randomElement()
            self.headerView?.configure(with: randomtitle!)
        }
    }
    private func configurewithData(with data: TrendingTitles){
        self.results = data
        self.Title = self.results?.results
    }
    
    
    
    private func NavConfigure(){
        var image = UIImage(named: "logo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
    }
    }



extension HomeViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as? CollectionViewTableViewCell else{
            return UITableViewCell()
        }
        cell.delegate = self
        
        switch indexPath.section{
            
        case Sections.TrendingMovies.rawValue:
            NetworkConnector.passingData(with: MethodType.getTrendingMovies) { data in
                cell.configure(with: data)
            }
        case Sections.TrendingTv.rawValue:
            NetworkConnector.passingData(with: MethodType.getTrendingTvs) { data in
                cell.configure(with: data)
            }
        case Sections.Popular.rawValue:
            NetworkConnector.passingData(with: MethodType.getPopular) { data in
                cell.configure(with: data)
            }
        case Sections.Upcoming.rawValue:
            NetworkConnector.passingData(with: MethodType.getUpComing) { data in
                cell.configure(with: data)
            }
        case Sections.TopRated.rawValue:
            NetworkConnector.passingData(with: MethodType.getTopRated) { data in
                cell.configure(with: data)
            }
        default:
            return UITableViewCell()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else{return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.lowercased()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
}
extension HomeViewController:CollectionViewTableViewCellDelegate{
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
