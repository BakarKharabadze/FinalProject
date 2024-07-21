//
//  ChannelVideosModel.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation

// MARK: - YouTubeSearchResponse
public struct ChannelVideosModel: Decodable {
    public let kind: String
    public let etag: String
    public let nextPageToken: String?
    public let regionCode: String
    public let pageInfo: PageInfo
    public let items: [Item]

    public struct PageInfo: Decodable {
        public let totalResults: Int
        public let resultsPerPage: Int
    }

    public struct Item: Decodable {
        public let kind: String
        public let etag: String
        public let id: Id
        public let snippet: Snippet

        public struct Id: Decodable {
            public let kind: String
            public let videoId: String?
        }

        public struct Snippet: Decodable {
            public let publishedAt: String
            public let channelId: String
            public let title: String
            public let description: String
            public let thumbnails: Thumbnails
            public let channelTitle: String
            public let liveBroadcastContent: String
            public let publishTime: String

            public struct Thumbnails: Decodable {
                public let defaultThumbnail: Thumbnail
                public let medium: Thumbnail
                public let high: Thumbnail

                public struct Thumbnail: Decodable {
                    public let url: String
                    public let width: Int
                    public let height: Int
                }

                private enum CodingKeys: String, CodingKey {
                    case defaultThumbnail = "default"
                    case medium
                    case high
                }
            }
        }
    }
}


