//
//  VideosRepository.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation
import Common

public protocol VideosRepository {
    func getVideos(channelId: String, maxResults: Int, order: String, apiKey: String, completion: @escaping (Result<[VideosEntity], Error>) -> Void) -> Cancellable?
}
