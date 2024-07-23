//
//  NewsAPIEndpoints.swift
//
//
//  Created by Bakar Kharabadze on 7/9/24.
//

import Foundation
import Domain
import Network

struct NewsAPIEndpoints {
    
    static func news(query: String, from: String, sortBy: String, language: String, apiKey: String) -> DataEndpoint<NewsResponse> {
        
        DataEndpoint(path: "/v2/everything",
                     queryParameters: ["q": query,
                                       "from": from,
                                       "sortBy": sortBy,
                                       "language": language,
                                       "apiKey": apiKey])
    }
}
