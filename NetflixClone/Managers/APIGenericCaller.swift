//
//  APIGenericCaller.swift
//  NetflixClone
//
//  Created by Madoo on 06/12/2022.
//

import Foundation
import Alamofire

struct Constants{
    static let API_KEY = "afb9fad43eb8930b0f49ff12d39a5387"
    static let BASE_URL = "https://api.themoviedb.org"
    static let YOUTUBE_API = "AIzaSyDex5P4MrYNv8zg1HGjr7ZCC0Ulm8OM-0k"
    static let YOUTUBE_BASE_URL = "https://youtube.googleapis.com/youtube/v3/search?"
    static let DISCOVER_CONSTANT = "&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
}
enum MethodType{
    case getTrendingMovies
    case getPopular
    case getTrendingTvs
    case getUpComing
    case getTopRated
    case getDiscoverMovies
}
protocol urlType{
    var url:String {get}
}
extension MethodType: urlType{
    var url: String {
        switch self{
        case .getTrendingMovies:
            return "\(Constants.BASE_URL)/3/trending/movie/day?api_key=\(Constants.API_KEY)"
                case .getTrendingTvs:
            return "\(Constants.BASE_URL)/3/trending/tv/day?api_key=\(Constants.API_KEY)"
        case .getPopular:
            return "\(Constants.BASE_URL)/3/movie/popular?api_key=\(Constants.API_KEY)"
        case .getTopRated:
            return "\(Constants.BASE_URL)/3/movie/top_rated?api_key=\(Constants.API_KEY)"
        case .getUpComing:
            return "\(Constants.BASE_URL)/3/movie/upcoming?api_key=\(Constants.API_KEY)"
        case .getDiscoverMovies:
            return "\(Constants.BASE_URL)/3/discover/movie?api_key=\(Constants.API_KEY)\(Constants.BASE_URL)"

        }
    }
}

class APIhandler{
    static let shared = APIhandler()
    
    func GenericAPIcalling<T:Codable>(type: MethodType, handler: @escaping (T) -> ()){
        Alamofire.request(type.url).responseJSON { response in
            let decoder = JSONDecoder()
            do {
                let parsedData = try decoder.decode(T.self, from: response.data!)
                handler(parsedData)
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
}
