//
//  VideosResponse+DomainMapping.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation
import Domain

extension VideosEntity {
    static func map(videosResponse: ChannelVideosModel) -> [VideosEntity] {
        videosResponse.items.compactMap { video in
            guard let videoId = video.id.videoId else { return nil }
            let snippet = video.snippet
            let title = snippet.title
            let thumbnailUrl = snippet.thumbnails.medium.url
            
            return VideosEntity(fetchedVideosTitle: title,
                                fetchedVideosImgUrl: thumbnailUrl,
                                fetchedVideosId: videoId)
        }
    }
}



