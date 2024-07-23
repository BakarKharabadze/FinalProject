//
//  GetNewsUseCase.swift
//
//
//  Created by Bakar Kharabadze on 7/9/24.
//

import Foundation
import Common

public protocol GetNewsUseCase {
    func execute(query: String, from: String, sortBy: String, language: String, apiKey: String, completion: @escaping (Result<[NewsEntity], Error>) -> Void) -> Cancellable?
}

public final class DefaultGetNewsUseCase: GetNewsUseCase {

    private let repository: NewsRepository
    
    public init(repository: NewsRepository) {
        self.repository = repository
    }

    
    public func execute(query: String, from: String, sortBy: String, language: String, apiKey: String, completion: @escaping (Result<[NewsEntity], any Error>) -> Void) -> Cancellable? {
        repository.getNews(query: query, from: from, sortBy: sortBy, language: language, apiKey: apiKey, with: completion)
        }
}
