//
//  HomeViewModel.swift
//  NetflixClone
//
//  Created by Madoo on 07/12/2022.
//

import Foundation


class ConnectingViewModel{
    
    func passingData<T:Codable>(with type: MethodType, handler: @escaping(T) -> ()){
        switch type{
        case.getUpComing:
            APIhandler.shared.GenericAPIcalling(type: MethodType.getUpComing) { data in
                handler(data)
            }
        case .getDiscoverMovies:
            APIhandler.shared.GenericAPIcalling(type: MethodType.getDiscoverMovies) { data in
                handler(data)
            }
        case.getTrendingMovies:
            APIhandler.shared.GenericAPIcalling(type: MethodType.getTrendingMovies) { data in
                handler(data)
            }
        case.getTrendingTvs:
            APIhandler.shared.GenericAPIcalling(type: MethodType.getTrendingMovies) { data in
                handler(data)
            }
        case.getPopular:
            APIhandler.shared.GenericAPIcalling(type: MethodType.getTrendingMovies) { data in
                handler(data)
            }
        case.getTopRated:
            APIhandler.shared.GenericAPIcalling(type: MethodType.getTrendingMovies) { data in
                handler(data)
            }
        }
    }
    func passingVideoElement(with query:String, handler:@escaping(YoutubeResults) -> ()){
        APIhandler.shared.GenericSearch(with: SearchType.getMovie, query: query) { video in
            handler(video)
        }
    }
    func passingSearchResults(with query:String, handler:@escaping(TrendingTitles) -> ()){
            APIhandler.shared.GenericSearch(with: SearchType.searchForitem, query: query) { data in
                handler(data)
            }
        }
    func configuringBigHeader(handler: @escaping(TrendingTitles) ->()){
        APIhandler.shared.GenericAPIcalling(type: MethodType.getTrendingMovies) { data in
            handler(data)
        }
    }
}
   
