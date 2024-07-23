//
//  GetTeamsUseCaseTests.swift
//
//
//  Created by Bakar Kharabadze on 7/19/24.
//

import XCTest
import Common
@testable import Domain

// Test case
final class GetTeamsUseCaseTests: XCTestCase {
    
    var useCase: DefaultGetTeamsUseCase!
    var repository: MockTeamsRepository!
    
    override func setUp() {
        super.setUp()
        repository = MockTeamsRepository()
        useCase = DefaultGetTeamsUseCase(repository: repository)
    }
    
    override func tearDown() {
        repository = nil
        useCase = nil
        super.tearDown()
    }
    
    func testExecuteSuccess() {
        // Given
        let expectedTeams = [TeamsEntity(
            position: "",
            constructorName: "",
            points: "",
            nationality: "",
            liveryImage: "",
            constructorID: ""
        )]
        repository.result = .success(expectedTeams)
        
        // When
        let expectation = self.expectation(description: "Completion handler called")
        var result: Result<[TeamsEntity], Error>?
        _ = useCase.execute { response in
            result = response
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        // Then
        switch result {
        case .success(let teams)?:
            XCTAssertEqual(teams, expectedTeams)
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
        var result: Result<[TeamsEntity], Error>?
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
public final class  MockTeamsRepository: TeamsRepository {
    
    var result: Result<[TeamsEntity], Error>?
    
    public func getTeams(completion: @escaping (Result<[TeamsEntity], Error>) -> Void) -> Cancellable? {
        if let result = result {
            completion(result)
        }
        return nil 
    }
}

