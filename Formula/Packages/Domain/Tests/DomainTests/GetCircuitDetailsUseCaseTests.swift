//
//  File.swift
//  
//
//  Created by Bakar Kharabadze on 7/19/24.
//

import XCTest
import Common
@testable import Domain

// Test Case
class GetCircuitDetailsUseCaseTests: XCTestCase {
    
    var useCase: DefaultGetCircuitDetailsUseCase!
    var repository: MockFormulaSportsRepository!
    
    override func setUp() {
        super.setUp()
        repository = MockFormulaSportsRepository()
        useCase = DefaultGetCircuitDetailsUseCase(repository: repository)
    }
    
    override func tearDown() {
        repository = nil
        useCase = nil
        super.tearDown()
    }
    
    func testExecuteSuccess() {
        // Given
        let expectedDetails = [CircuitDetailsEntity(
            countryName: "",
            grandPrixName: "",
            date: "",
            circuitLenght: "",
            laps: "",
            turns: "",
            topSpeed: "",
            practiceOneDate: "",
            practiceOneTime: "",
            practiceTwoDate: "",
            practiceTwoTime: "",
            practiceThreeDate: "",
            practiceThreeTime: "",
            qualificationDate: "",
            qualificationTime: "",
            raceDate: "",
            raceTime: ""
        )]
        repository.result = .success(expectedDetails)
        
        // When
        let expectation = self.expectation(description: "Completion handler called")
        var result: Result<[CircuitDetailsEntity], Error>?
        _ = useCase.execute(for: "Circuit1") { response in
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
        var result: Result<[CircuitDetailsEntity], Error>?
        _ = useCase.execute(for: "Circuit1") { response in
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
class MockFormulaSportsRepository: FormulaSportsRepository {
    
    var result: Result<[CircuitDetailsEntity], Error>?
    
    func getCircuitDetails(for circuitName: String, completion: @escaping (Result<[CircuitDetailsEntity], Error>) -> Void) -> Cancellable? {
        if let result = result {
            completion(result)
        }
        return nil 
    }
}
