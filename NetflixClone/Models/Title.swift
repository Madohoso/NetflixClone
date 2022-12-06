//
//  Title.swift
//  NetflixClone
//
//  Created by Madoo on 29/11/2022.
//

import Foundation
struct TrendingTitles:Codable{
    var results:[mytitle]?
}
struct mytitle:Codable{
    var id:Int?
    var original_title:String?
    var original_name:String?
    var poster_path:String?
    var vote_count:Int
    var overview:String?
    var release_date:String?
    var vote_average:Double
}
