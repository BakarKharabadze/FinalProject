//
//  GetDriverDetailsUseCaseTests.swift
//
//
//  Created by Bakar Kharabadze on 7/19/24.
//

import XCTest
import Common
@testable import Domain

// Test Case
final class GetDriverDetailsUseCaseTests: XCTestCase {
    
    var useCase: DefaultGetDriversDetailsUseCase!
    var repository: MockDriverDetailsRepository!
    
    override func setUp() {
        super.setUp()
        repository = MockDriverDetailsRepository()
        useCase = DefaultGetDriversDetailsUseCase(repository: repository)
    }
    
    override func tearDown() {
        repository = nil
        useCase = nil
        super.tearDown()
    }
    
    func testExecuteSuccess() {
        // Given
        let expectedDetails = [DriverDetailsEntity(
            name: "",
            driverNumber: "",
            teamName: "",
            races: "",
            worldTitle: "",
            raceWins: "",
            podiums: "",
            nationality: "",
            birthday: "",
            birthPlace: ""
        )]
        repository.result = .success(expectedDetails)
        
        // When
        let expectation = self.expectation(description: "Completion handler called")
        var result: Result<[DriverDetailsEntity], Error>?
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
        var result: Result<[DriverDetailsEntity], Error>?
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
public final class MockDriverDetailsRepository: DriverDetailsRepository {
    
    
    var result: Result<[DriverDetailsEntity], Error>?
    
    public init() {}

    public func getCircuitDetails(completion: @escaping (Result<[Domain.DriverDetailsEntity], any Error>) -> Void) -> (any Common.Cancellable)? {
        if let result = result {
            completion(result)
        }
        return nil
    }
}
