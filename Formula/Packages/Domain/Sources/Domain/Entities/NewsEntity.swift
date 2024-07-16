//
//  File.swift
//  
//
//  Created by Bakar Kharabadze on 7/8/24.
//

import Foundation

public struct NewsEntity {
    public let title: String
    public let description: String?
    public let url: String
    public let urlToImage: String?
    public let publishedAt: String
    public let content: String
    
    public init(title: String, description: String?, url: String, urlToImage: String?, publishedAt: String, content: String) {
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}
