//
//  HighlightViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation
import Domain

public protocol HighlightsViewModelDelegate: AnyObject {
    func videosFetched(_ videos: [VideosEntity])
}

public final class HighlightsViewModel {
    
    weak var delegate: HighlightsViewModelDelegate?
    private let getVideosUseCase: GetVideosUseCase
    public var videos: [VideosEntity] = []
    
    public init(getVideosUseCase: GetVideosUseCase) {
        self.getVideosUseCase = getVideosUseCase
    }
    
    func viewDidLoad() {
        fetchVideos(channelId: "UCB_qr75-ydFVKSF9Dmo6izg", maxResults: 50, order: "date", apiKey: "AIzaSyBIIfbiqHk725UMvOyR1HYJNtdycXd2z-c")
    }
    
    func fetchVideos(channelId: String, maxResults: Int, order: String, apiKey: String) {
        getVideosUseCase.execute(channelId: channelId, maxResults: maxResults, order: order, apiKey: apiKey) { [weak self] result in
            switch result {
            case .success(let videos):
                self?.videos = videos
                DispatchQueue.main.async {
                    self?.delegate?.videosFetched(videos)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
