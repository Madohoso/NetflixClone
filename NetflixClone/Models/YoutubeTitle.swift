//
//  YoutubeTitle.swift
//  NetflixClone
//
//  Created by Madoo on 03/12/2022.
//

import Foundation

struct YoutubeResults:Codable{
    var items: [VideoElement]?
}
struct VideoElement:Codable{
    var id: IdVideoElement?
}
struct IdVideoElement:Codable{
    var kind: String?
    var videoId: String?
}
