//
//  DefaultNewsRepository.swift
//
//
//  Created by Bakar Kharabadze on 7/9/24.
//

import Foundation
import Domain
import Network
import Common

public final class DefaultNewsRepository {
    
    // MARK: - Properties
    private let dataTransferService: DataTransfer
    
    // MARK: - Initialization
    public init(dataTransferService: DataTransfer) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - NewsRepository
extension DefaultNewsRepository: NewsRepository {
    public func getNews(query: String, from: String, sortBy: String, language: String, apiKey: String, with result: @escaping (Result<[NewsEntity], any Error>) -> Void) -> Cancellable? {
        
        let endpoint = NewsAPIEndpoints.news(query: query, from: from, sortBy: sortBy, language: language, apiKey: apiKey)
        
        return self.dataTransferService.request(with: endpoint) { (response: Result<NewsResponse, Error>) in
            switch response {
            case .success(let news):
                result(.success(NewsEntity.map(newsResponse: news)))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
