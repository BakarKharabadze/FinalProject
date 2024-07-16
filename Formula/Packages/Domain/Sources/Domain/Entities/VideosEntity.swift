//
//  VideosEntity.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation

public struct VideosEntity {
    public let fetchedVideosTitle: String
    public let fetchedVideosImgUrl: String
    public let fetchedVideosId: String
    public var videoURL: String {
        return "https://www.youtube.com/watch?v=\(fetchedVideosId)"
    }
    
    public init(fetchedVideosTitle: String, fetchedVideosImgUrl: String, fetchedVideosId: String) {
        self.fetchedVideosTitle = fetchedVideosTitle
        self.fetchedVideosImgUrl = fetchedVideosImgUrl
        self.fetchedVideosId = fetchedVideosId
    }
}

