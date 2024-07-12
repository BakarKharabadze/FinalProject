//
//  GetVideosUseCase.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation
import Common

public protocol GetVideosUseCase {
    func execute(channelId: String, maxResults: Int, order: String, apiKey: String, completion: @escaping (Result<[VideosEntity], Error>) -> Void) -> Cancellable?
}

public final class DefaultGetVideosUseCase: GetVideosUseCase {
    private let repository: VideosRepository
    
    public init(repository: VideosRepository) {
        self.repository = repository
    }
    
    public func execute(channelId: String, maxResults: Int, order: String, apiKey: String, completion: @escaping (Result<[VideosEntity], any Error>) -> Void) -> Cancellable? {
        repository.getVideos(channelId: channelId, maxResults: maxResults, order: order, apiKey: apiKey, completion: completion)
    }
}
