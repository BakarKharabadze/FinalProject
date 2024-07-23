//
//  HighlightsViewModelTests.swift
//
//
//  Created by Bakar Kharabadze on 7/23/24.
//

import XCTest
import Domain
import Common
@testable import Presentation

class HighlightsViewModelTests: XCTestCase {

    // Tests
    func testViewDidLoad_fetchesVideos() {
        let videosUseCase = MockGetVideosUseCase()
        let viewModel = HighlightsViewModel(getVideosUseCase: videosUseCase)
        
        viewModel.viewDidLoad()
        
        XCTAssertTrue(videosUseCase.executeCalled)
    }
    
    func testFetchVideos_success() {
        let videosUseCase = MockGetVideosUseCase()
        let delegate = MockHighlightsViewModelDelegate()
        let viewModel = HighlightsViewModel(getVideosUseCase: videosUseCase)
        viewModel.delegate = delegate
        
        let expectation = self.expectation(description: "FetchVideos")
        
        videosUseCase.result = .success(mockVideos)
        
        viewModel.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(delegate.videosFetchedCalled)
            XCTAssertEqual(viewModel.videos, self.mockVideos)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testFetchVideos_failure() {
        let videosUseCase = MockGetVideosUseCase()
        let delegate = MockHighlightsViewModelDelegate()
        let viewModel = HighlightsViewModel(getVideosUseCase: videosUseCase)
        viewModel.delegate = delegate
        
        let expectation = self.expectation(description: "FetchVideosFailure")
        
        let error = NSError(domain: "Test", code: 1, userInfo: nil)
        videosUseCase.result = .failure(error)
        
        viewModel.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(delegate.videosFetchedCalled)
            XCTAssertEqual(viewModel.videos, [])
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }    
    
    // Mock Classes
    class MockGetVideosUseCase: GetVideosUseCase {
        var executeCalled = false
        var result: Result<[VideosEntity], Error>?
        
        func execute(channelId: String, maxResults: Int, order: String, apiKey: String, completion: @escaping (Result<[VideosEntity], Error>) -> Void) -> Cancellable? {
            executeCalled = true
            if let result {
                completion(result)
            }
            return nil
        }
    }
    
    class MockHighlightsViewModelDelegate: HighlightsViewModelDelegate {
        var videosFetchedCalled = false
        
        func videosFetched(_ videos: [VideosEntity]) {
            videosFetchedCalled = true
        }
    }
    
    // Mock Entities
    let mockVideos = [VideosEntity(fetchedVideosTitle: "Video Title", fetchedVideosImgUrl: "https://videoimgurl.com", fetchedVideosId: "videoId")]

}

