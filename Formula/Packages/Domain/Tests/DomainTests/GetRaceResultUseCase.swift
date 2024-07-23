//
//  GetRaceResultUseCaseTests.swift
//
//
//  Created by Bakar Kharabadze on 7/16/24.
//

import Common
import XCTest
@testable import Domain

// Test Case
final class GetRaceResultUseCaseTests: XCTestCase {
    
    var useCase: DefaultGetRaceResultUseCase!
    var repository: MockRaceResultRepository!
    
    override func setUp() {
        super.setUp()
        repository = MockRaceResultRepository()
        useCase = DefaultGetRaceResultUseCase(repository: repository)
    }
    
    override func tearDown() {
        repository = nil
        useCase = nil
        super.tearDown()
    }
    
    func testExecuteSuccess() {
        // Given
        let expectedResults = [RaceResultEntity(
            round: "",
            grandPrixName: "",
            date: "",
            circuitId: "",
            firstPlaceLastName: "",
            secondPlaceLastName: "",
            thirdPlaceLastName: ""
        )
           ]
        repository.result = .success(expectedResults)
        
        // When
        let expectation = self.expectation(description: "Completion handler called")
        var receivedResult: Result<[RaceResultEntity], Error>?
        _ = useCase.execute { response in
            receivedResult = response
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        // Then
        switch receivedResult {
        case .success(let results)?:
            XCTAssertEqual(results, expectedResults)
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
        var receivedResult: Result<[RaceResultEntity], Error>?
        _ = useCase.execute { response in
            receivedResult = response
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        // Then
        switch receivedResult {
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
public final class  MockRaceResultRepository: RaceResultRepository {
    
    var result: Result<[RaceResultEntity], Error>?
    
    public func getRaceResult(result: @escaping (Result<[RaceResultEntity], Error>) -> Void) -> Cancellable? {
        if let resultValue = self.result {
            result(resultValue)
        }
        return nil
    }
}
