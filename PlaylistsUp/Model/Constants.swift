//
//  Constants.swift
//  PlaylistsUp
//
//  Created by Muskan on 06/06/22.
//

import Foundation

struct Constants {
    
    static var ApiKey = "AIzaSyCwYqOQObPbG7z8aZdATRbt4t1TUHcWsx0"
    static var playlistId = "PLsVSF-hJhvBJba780QZDAdwKy3POaerO-"
    static var apiUrl = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(playlistId)&key=\(ApiKey)"
    static var videoCell = "videoCell"
    static var ytEmbedUrl = "https://www.youtube.com/watch?v="
}
