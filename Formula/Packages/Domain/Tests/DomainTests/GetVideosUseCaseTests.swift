//
//  GetVideosUseCaseTests.swift
//
//
//  Created by Bakar Kharabadze on 7/19/24.
//

import XCTest
import Common
@testable import Domain

class GetVideosUseCaseTests: XCTestCase {
    
    var useCase: DefaultGetVideosUseCase!
    var repository: MockVideosRepository!
    
    override func setUp() {
        super.setUp()
        repository = MockVideosRepository()
        useCase = DefaultGetVideosUseCase(repository: repository)
    }
    
    override func tearDown() {
        repository = nil
        useCase = nil
        super.tearDown()
    }
    
    func testExecuteSuccess() {
        // Given
        let expectedVideos = [VideosEntity(
            fetchedVideosTitle: "",
            fetchedVideosImgUrl: "",
            fetchedVideosId: "")]
        repository.result = .success(expectedVideos)
        
        // When
        let expectation = self.expectation(description: "Completion handler called")
        var result: Result<[VideosEntity], Error>?
        _ = useCase.execute(channelId: "channelId", maxResults: 10, order: "date", apiKey: "apiKey") { response in
            result = response
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        // Then
        switch result {
        case .success(let videos)?:
            XCTAssertEqual(videos, expectedVideos)
        case .failure, .none:
            XCTFail("Expected success, but got failure or nil")
        }
    }
    
    func testExecuteFailure() {
        // Given
        let expectedError = NSError(domain: "TestError", code: 0, userInfo: nil)
        repository.result = .failure(expectedError)
        
        // When
        let expectation = self.expectation(description: "Completion handler called")
        var result: Result<[VideosEntity], Error>?
        _ = useCase.execute(channelId: "channelId", maxResults: 10, order: "date", apiKey: "apiKey") { response in
            result = response
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure, but got success")
        case .failure(let error as NSError)?:
            XCTAssertEqual(error, expectedError)
        case .none:
            XCTFail("Expected failure, but got nil")
        }
    }
}

class MockVideosRepository: VideosRepository {
    
    var result: Result<[VideosEntity], Error>?
    
    func getVideos(channelId: String, maxResults: Int, order: String, apiKey: String, completion: @escaping (Result<[VideosEntity], Error>) -> Void) -> Cancellable? {
        if let result = result {
            completion(result)
        }
        return nil 
    }
}

