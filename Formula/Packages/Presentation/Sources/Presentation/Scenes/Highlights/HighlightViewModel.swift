//
//  HighlightViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation
import Domain

//MARK: - HighlightsViewModelDelegate
public protocol HighlightsViewModelDelegate: AnyObject {
    func videosFetched(_ videos: [VideosEntity])
}

//MARK: - HighlightsViewModel
public final class HighlightsViewModel {
    
    //MARK: - Properties
    weak var delegate: HighlightsViewModelDelegate?
    private let getVideosUseCase: GetVideosUseCase
    public var videos: [VideosEntity] = []
    //MARK: - Init
    public init(getVideosUseCase: GetVideosUseCase) {
        self.getVideosUseCase = getVideosUseCase
    }
    
    //MARK: - Methods
    func viewDidLoad() {
        fetchVideos(channelId: "UCB_qr75-ydFVKSF9Dmo6izg", maxResults: 50, order: "date", apiKey: "AIzaSyBIIfbiqHk725UMvOyR1HYJNtdycXd2z-c")
    }
    
    private func fetchVideos(channelId: String, maxResults: Int, order: String, apiKey: String) {
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
