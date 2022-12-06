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
    let sectionTitles:[String] = ["Trending Movies","Trending Tv","Popular", "Upcoming Movies", "Top rated"]
    @IBOutlet weak var homeFeedTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        NavConfigure()
        let headerView = BigHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        let vc = storyboard?.instantiateViewController(withIdentifier: "TitlePreview")
        navigationController?.pushViewController(vc!, animated: true)
        navigationItem.backButtonTitle = " "
//        navigationController?.navigationBar.tintColor = .white
//        bos ana hena 3amel tr2ten lel titlepreview wahda btsht3'al bs el webview msh zaher wa el tanya msh btzhar aslan
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
            APIcaller.shared.getTrendingMovies { response in
                cell.configure(with: response)
            }
        case Sections.TrendingTv.rawValue:
            APIcaller.shared.getTrendingTvs { response in
                cell.configure(with: response)
            }
        case Sections.Popular.rawValue:
            APIcaller.shared.getPopular{ response in
                cell.configure(with: response)
            }
        case Sections.Upcoming.rawValue:
            APIcaller.shared.getUpComing { response in
                cell.configure(with: response)
            }
        case Sections.TopRated.rawValue:
            APIcaller.shared.getTopRated { response in
                cell.configure(with: response)
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
extension HomeViewController:CollectionViewTbaleViewCellDelegate{
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
