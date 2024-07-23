//
//  File.swift
//
//
//  Created by Bakar Kharabadze on 7/19/24.
//

import Common
import XCTest
@testable import Domain

// Test Case
final class GetRacesUseCaseTests: XCTestCase {
    
    var useCase: DefaultGetRacesUseCase!
    var repository: MockRaceRepository!
    
    override func setUp() {
        super.setUp()
        repository = MockRaceRepository()
        useCase = DefaultGetRacesUseCase(repository: repository)
    }
    
    override func tearDown() {
        repository = nil
        useCase = nil
        super.tearDown()
    }
    
    func testExecuteSuccess() {
        // Given
        let expectedRaces = [RaceEntity(
            round: "",
            grandPrixName: "",
            circuitName: "",
            date: "",
            time: "",
            image: "",
            startsIn: "",
            countryFlag: "",
            circuitID: "",
            turns: "",
            topSpeed: "",
            practiceOneDate: "",
            practiceOneTime: "",
            practiceTwoDate: "",
            practiceTwoTime: "",
            practiceThreeDate: "",
            practiceThreeTime: "",
            qualificationDate: "",
            qualificationTime: ""
        )]
        repository.result = .success(expectedRaces)
        
        // When
        let expectation = self.expectation(description: "Completion handler called")
        var receivedResult: Result<[RaceEntity], Error>?
        _ = useCase.execute { response in
            receivedResult = response
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        // Then
        switch receivedResult {
        case .success(let races)?:
            XCTAssertEqual(races, expectedRaces)
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
        var receivedResult: Result<[RaceEntity], Error>?
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
public final class  MockRaceRepository: RaceRepository {
    
    var result: Result<[RaceEntity], Error>?
    
    public func getRaces(result: @escaping (Result<[RaceEntity], Error>) -> Void) -> Cancellable? {
        if let resultValue = self.result {
            result(resultValue)
        }
        return nil
    }
}
