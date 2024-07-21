//
//  NewsResponse+DomainMapping.swift
//
//
//  Created by Bakar Kharabadze on 7/9/24.
//

import Foundation
import Domain

extension NewsEntity {
    static func map(newsResponse: NewsResponse) -> [NewsEntity] {
        newsResponse.articles.map { article in
            NewsEntity(title: article.title,
                       description: article.description,
                       url: article.url,
                       urlToImage: article.urlToImage,
                       publishedAt: article.publishedAt, 
                       content: article.content)
        }
    }
}

