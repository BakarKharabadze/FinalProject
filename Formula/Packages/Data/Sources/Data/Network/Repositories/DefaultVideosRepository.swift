//
//  DefaultVideosRepository.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation
import Domain
import Network
import Common

public final class DefaultVideosRepository {
    private let dataTransferService: DataTransfer
    
    public init(dataTransferService: DataTransfer) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultVideosRepository: VideosRepository {
    
    public func getVideos(channelId: String, maxResults: Int, order: String, apiKey: String, completion: @escaping (Result<[Domain.VideosEntity], any Error>) -> Void) -> Cancellable? {
        
        let endpoint = VideosAPIEndpoints.videos(channelId: channelId, maxResults: maxResults, order: order, apiKey: apiKey)
        
        return self.dataTransferService.request(with: endpoint) { (response: Result<ChannelVideosModel, Error>) in
            switch response  {
            case .success(let videosResponse):
                let videosEntities = VideosEntity.map(videosResponse: videosResponse)
                completion(.success(videosEntities))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


