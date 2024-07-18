//
//  GetTeamDetailsUseCaseTests.swift
//
//
//  Created by Bakar Kharabadze on 7/19/24.
//

import Common
import XCTest
@testable import Domain

// Test Case
class GetTeamDetailsUseCaseTests: XCTestCase {
    
    var useCase: DefaultGetTeamDetailsUseCase!
    var repository: MockTeamDetailsRepository!
    
    override func setUp() {
        super.setUp()
        repository = MockTeamDetailsRepository()
        useCase = DefaultGetTeamDetailsUseCase(repository: repository)
    }
    
    override func tearDown() {
        repository = nil
        useCase = nil
        super.tearDown()
    }
    
    func testExecuteSuccess() {
        // Given
        let expectedDetails = [TeamDetailsEntity(
            name: "",
            worldTitle: "",
            raceWins: "",
            polePositions: "",
            fastesLaps: "",
            base: "",
            president: "",
            director: "",
            technicalManeger: "")]
        repository.result = .success(expectedDetails)
        
        // When
        let expectation = self.expectation(description: "Completion handler called")
        var result: Result<[TeamDetailsEntity], Error>?
        _ = useCase.execute { response in
            result = response
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        // Then
        switch result {
        case .success(let details)?:
            XCTAssertEqual(details, expectedDetails)
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
        var result: Result<[TeamDetailsEntity], Error>?
        _ = useCase.execute { response in
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
class MockTeamDetailsRepository: TeamDetailsRepository {
    
    var result: Result<[TeamDetailsEntity], Error>?
    
    func getTeamDetails(completion: @escaping (Result<[TeamDetailsEntity], Error>) -> Void) -> Cancellable? {
        if let result = result {
            completion(result)
        }
        return nil 
    }
}

