//
//  VideosAPIEndpoints.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation
import Domain
import Network

struct VideosAPIEndpoints {
    static func videos(channelId: String, maxResults: Int, order: String, apiKey: String) -> DataEndpoint<ChannelVideosModel> {
        
        return DataEndpoint(path: "/youtube/v3/search",
                            queryParameters: ["part": "snippet",
                                              "channelId": channelId,
                                              "maxResults": String(maxResults),
                                              "order": order,
                                              "key": apiKey])
    }
}

