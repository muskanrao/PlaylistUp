//
//  Video.swift
//  PlaylistsUp
//
//  Created by Muskan on 06/06/22.
//

import Foundation


struct Video: Decodable {
    
    var videoId = ""
    var title = ""
    var description = ""
    var thumbnail = ""
    var published  = Date()
    
    enum CodingKeys: String , CodingKey{
        
        case snippet
        case thumbnails
        case high
        case resourceId
        case published = "publishedAt"
        case title
        case description
        case thumbnail = "url"
        case videoId
        
    }
    
    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
        //parse title
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        
        //parse decription
        self.description = try snippetContainer.decode(String.self, forKey: .description)
        
        //parse publish date
        self.published = try snippetContainer.decode(Date.self, forKey: .published)
        
        //parse thumbnails
        let thumbnailContainer =  try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        let highContainer = try thumbnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        
        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)
        
        //video id
        
        let resourceContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        self.videoId = try resourceContainer.decode(String.self, forKey: .videoId)
         
        
    }
    
}
