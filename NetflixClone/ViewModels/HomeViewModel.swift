//
//  HomeViewModel.swift
//  NetflixClone
//
//  Created by Madoo on 07/12/2022.
//

import Foundation

enum sections: Int{
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}
class HomeViewModel{
    let sectionTitles:[String] = ["Trending Movies","Trending Tv","Popular", "Upcoming Movies", "Top rated"]
    static let shared = HomeViewModel()
    
    var results: TrendingTitles?
    
    func passingData(with casenumber:Int, handler: @escaping (TrendingTitles) -> ()){
        switch casenumber{
        case sections.TrendingMovies.rawValue:
            APIhandler.shared.GenericAPIcalling(type: MethodType.getTrendingMovies) { data in
                handler(data)
            }
        case sections.TrendingTv.rawValue:
            APIhandler.shared.GenericAPIcalling(type: MethodType.getTrendingTvs) { data in
                handler(data)
            }
        case sections.Popular.rawValue:
            APIhandler.shared.GenericAPIcalling(type: MethodType.getPopular) { data in
                handler(data)
            }
        case sections.Upcoming.rawValue:
            APIhandler.shared.GenericAPIcalling(type: MethodType.getUpComing) { data in
                handler(data)
            }
        case sections.TopRated.rawValue:
            APIhandler.shared.GenericAPIcalling(type: MethodType.getTopRated) { data in
                handler(data)
            }
        default:
            return
        }
    }
}
