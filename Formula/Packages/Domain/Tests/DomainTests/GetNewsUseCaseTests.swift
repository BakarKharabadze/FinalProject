//
//  GetNewsUseCaseTests.swift
//
//
//  Created by Bakar Kharabadze on 7/19/24.
//

import XCTest
import Common
@testable import Domain

// Test Case
class GetNewsUseCaseTests: XCTestCase {
    
    var useCase: DefaultGetNewsUseCase!
    var repository: MockNewsRepository!
    
    override func setUp() {
        super.setUp()
        repository = MockNewsRepository()
        useCase = DefaultGetNewsUseCase(repository: repository)
    }
    
    override func tearDown() {
        repository = nil
        useCase = nil
        super.tearDown()
    }
    
    func testExecuteSuccess() {
        // Given
        let expectedNews = [NewsEntity(
            title: "Test Title",
            description: "Test Description",
            url: "http://test.com",
            urlToImage: "http://test.com/image.jpg",
            publishedAt: "2024-07-19",
            content: "Test Content")]
        repository.result = .success(expectedNews)
        
        // When
        let expectation = self.expectation(description: "Completion handler called")
        var result: Result<[NewsEntity], Error>?
        _ = useCase.execute(query: "test", from: "2024-07-19", sortBy: "publishedAt", language: "en", apiKey: "apiKey") { response in
            result = response
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        // Then
        switch result {
        case .success(let news)?:
            XCTAssertEqual(news, expectedNews)
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
        var result: Result<[NewsEntity], Error>?
        _ = useCase.execute(query: "test", from: "2024-07-19", sortBy: "publishedAt", language: "en", apiKey: "apiKey") { response in
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

// Mock Repository
public class MockNewsRepository: NewsRepository {
    
    var result: Result<[NewsEntity], Error>?
    
    public init() {}

    public func getNews(query: String, from: String, sortBy: String, language: String, apiKey: String, with completion: @escaping (Result<[NewsEntity], Error>) -> Void) -> Cancellable? {
        if let result = result {
            completion(result)
        }
        return nil
    }
}
