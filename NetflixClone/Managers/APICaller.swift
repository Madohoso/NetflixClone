//
//  APICaller.swift
//  NetflixClone
//
//  Created by Madoo on 29/11/2022.
//

import Foundation
import Alamofire

    struct constants {
        static let API_KEY = "afb9fad43eb8930b0f49ff12d39a5387"
        static let BASE_URL = "https://api.themoviedb.org"
        static let YOUTUBE_API = "AIzaSyDex5P4MrYNv8zg1HGjr7ZCC0Ulm8OM-0k"
        static let YOUTUBE_BASE_URL = "https://youtube.googleapis.com/youtube/v3/search?"
    }
class APIcaller{
    static let shared = APIcaller()
    
    
    func getTrendingMovies(completion: @escaping (TrendingTitles) -> Void){
        Alamofire.request("\(constants.BASE_URL)/3/trending/movie/day?api_key=\(constants.API_KEY)").responseJSON { response in
            let decoder = JSONDecoder()
            do {
                let parsedData = try decoder.decode(TrendingTitles.self, from: response.data!)
                completion(parsedData)
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    func getPopular(completion: @escaping (TrendingTitles) -> Void){
        Alamofire.request("\(constants.BASE_URL)/3/movie/popular?api_key=\(constants.API_KEY)").responseJSON { response in
            let decoder = JSONDecoder()
            do {
                let parsedData = try decoder.decode(TrendingTitles.self, from: response.data!)
                completion(parsedData)
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    func getTrendingTvs(completion: @escaping (TrendingTitles) -> Void){
        Alamofire.request("\(constants.BASE_URL)/3/trending/tv/day?api_key=\(constants.API_KEY)").responseJSON { response in
            let decoder = JSONDecoder()
            do {
                let parsedData = try decoder.decode(TrendingTitles.self, from: response.data!)
                completion(parsedData)
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    func getUpComing(completion: @escaping (TrendingTitles) -> Void){
        Alamofire.request("\(constants.BASE_URL)/3/movie/upcoming?api_key=\(constants.API_KEY)").responseJSON { response in
            let decoder = JSONDecoder()
            do {
                let parsedData = try decoder.decode(TrendingTitles.self, from: response.data!)
                completion(parsedData)
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    func getTopRated(completion: @escaping (TrendingTitles) -> Void){
        Alamofire.request("\(constants.BASE_URL)/3/movie/top_rated?api_key=\(constants.API_KEY)").responseJSON { response in
            let decoder = JSONDecoder()
            do {
                let parsedData = try decoder.decode(TrendingTitles.self, from: response.data!)
                completion(parsedData)
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    func getDiscoverMovies(completion: @escaping (TrendingTitles) -> Void){
        Alamofire.request("\(constants.BASE_URL)/3/discover/movie?api_key=\(constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate").responseJSON { response in
            let decoder = JSONDecoder()
            do {
                let parsedData = try decoder.decode(TrendingTitles.self, from: response.data!)
                completion(parsedData)
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    func searchForitem(with query:String , completion: @escaping (TrendingTitles) -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else{return}
        Alamofire.request("\(constants.BASE_URL)/3/search/movie?api_key=\(constants.API_KEY)&query=\(query)").responseJSON { response in
            let decoder = JSONDecoder()
            do {
                let parsedData = try decoder.decode(TrendingTitles.self, from: response.data!)
                completion(parsedData)
            }
            catch{
                print(error.localizedDescription)
            }
        }
        
    }
    func getMovie(with query:String , completion: @escaping (YoutubeResults) -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        Alamofire.request("\(constants.YOUTUBE_BASE_URL)q=\(query)&key=\(constants.YOUTUBE_API)").responseJSON { response in
            let decoder = JSONDecoder()
            do {
                let parsedData = try decoder.decode(YoutubeResults.self, from: response.data!)
                completion(parsedData)
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
}
