//
//  NewsDetailViewModelTests.swift
//
//
//  Created by Bakar Kharabadze on 7/9/24.
//

import XCTest
import Domain
@testable import Presentation

class NewsDetailViewModelTests: XCTestCase {
    
    // Mock Delegate
    class MockNewsDetailViewModelDelegate: NewsDetailViewModelDelegate {
        var imageFetchedCalled = false
        var fetchedImageData: Data?
        var expectation: XCTestExpectation?
        
        func imageFetched(_ imageData: Data?) {
            imageFetchedCalled = true
            fetchedImageData = imageData
            expectation?.fulfill()
        }
    }
    
    // Properties
    var viewModel: NewsDetailViewModel!
    var mockDelegate: MockNewsDetailViewModelDelegate!
    
    // Mock Data
    let mockNews = NewsEntity(
        title: "Test Title",
        description: "Test Description",
        url: "https://example.com",
        urlToImage: "https://example.com/image.png",
        publishedAt: "2024-07-23T12:34:56Z",
        content: "Test Content"
    )
    
    override func setUp() {
        super.setUp()
        mockDelegate = MockNewsDetailViewModelDelegate()
        viewModel = NewsDetailViewModel(news: mockNews)
        viewModel.delegate = mockDelegate
    }
    
    override func tearDown() {
        viewModel = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func testFetchImage_Success() {
        // Given
        let imageData = "Mock Image Data".data(using: .utf8)
        let expectation = self.expectation(description: "Image fetched")
        mockDelegate.expectation = expectation
        
        // URLSession Configuration
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, imageData)
        }
        
        // When
        viewModel.fetchImage()
        
        // Then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(mockDelegate.imageFetchedCalled)
    }
    
    func testFetchImage_Failure() {
        // Given
        let expectation = self.expectation(description: "Image fetch failed")
        mockDelegate.expectation = expectation
        
        // URLSession Configuration
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 404, httpVersion: nil, headerFields: nil)!
            return (response, nil)
        }
        
        // When
        viewModel.fetchImage()
        
        // Then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(mockDelegate.imageFetchedCalled)
    }
}

// Mock URL Protocol
class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) -> (HTTPURLResponse, Data?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            fatalError("Handler is unavailable.")
        }
        
        let (response, data) = handler(request)
        
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
    
    }
}
