//
//  GetDriversUseCaseTests.swift
//
//
//  Created by Bakar Kharabadze on 7/19/24.
//

import XCTest
import Common
@testable import Domain


// Test Case
class GetDriversUseCaseTests: XCTestCase {
    
    var useCase: DefaultGetDriversUseCase!
    var repository: MockDriversRepository!
    
    override func setUp() {
        super.setUp()
        repository = MockDriversRepository()
        useCase = DefaultGetDriversUseCase(repository: repository)
    }
    
    override func tearDown() {
        repository = nil
        useCase = nil
        super.tearDown()
    }
    
    func testExecuteSuccess() {
        // Given
        let expectedDrivers = [DriverEntity(
            driverId: "",
            position: "",
            givenName: "",
            familyName: "",
            constructorName: "",
            points: "",
            driverImage: ""
        )]
        repository.result = .success(expectedDrivers)
        
        // When
        let expectation = self.expectation(description: "Completion handler called")
        var result: Result<[DriverEntity], Error>?
        _ = useCase.execute { response in
            result = response
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        // Then
        switch result {
        case .success(let drivers)?:
            XCTAssertEqual(drivers, expectedDrivers)
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
        var result: Result<[DriverEntity], Error>?
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
public class MockDriversRepository: DriversRepository {
    
    var result: Result<[DriverEntity], Error>?
    
    public init() {}

    public func getDrivers(completion: @escaping (Result<[DriverEntity], Error>) -> Void) -> Cancellable? {
        if let result = result {
            completion(result)
        }
        return nil
    }
}
