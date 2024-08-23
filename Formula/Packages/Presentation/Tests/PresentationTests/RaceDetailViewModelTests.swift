//
//  RaceDetailViewModelTests.swift
//
//
//  Created by Bakar Kharabadze on 7/14/24.
//

import XCTest
import Domain
import Common
@testable import Presentation

class RaceDetailViewModelTests: XCTestCase {
    
    // Properties
    var viewModel: RaceDetailViewModel!
    var mockUseCase: MockGetCircuitDetailsUseCase!
    var mockDelegate: MockRaceDetailViewModelDelegate!
    
    // Mock Data
    let mockRace = RaceEntity(
        round: "1",
        grandPrixName: "Australian Grand Prix",
        circuitName: "Albert Park Circuit",
        date: "2024-03-17",
        time: "16:00",
        image: "australian_gp_image_url",
        startsIn: "2 weeks",
        countryFlag: "australian_flag_url",
        circuitID: "albert_park",
        turns: "16",
        topSpeed: "320 km/h",
        practiceOneDate: "2024-03-15",
        practiceOneTime: "12:00",
        practiceTwoDate: "2024-03-15",
        practiceTwoTime: "16:00",
        practiceThreeDate: "2024-03-16",
        practiceThreeTime: "13:00",
        qualificationDate: "2024-03-16",
        qualificationTime: "16:00"
    )
    
    let mockCircuitDetails = [
        CircuitDetailsEntity(
            countryName: "Australia",
            grandPrixName: "Australian Grand Prix",
            date: "1950",
            circuitLenght: "5.303 km",
            laps: "58",
            raceDistance: "307.574 km"
        )
    ]
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockGetCircuitDetailsUseCase()
        mockDelegate = MockRaceDetailViewModelDelegate()
        viewModel = RaceDetailViewModel(race: mockRace, getCircuitDetailsUseCase: mockUseCase)
        viewModel.delegate = mockDelegate
    }
    
    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func testViewDidLoad_fetchesCircuitDetailsSuccessfully() {
        // Given
        mockUseCase.result = .success(mockCircuitDetails)
        let expectation = self.expectation(description: "Circuit details fetched")
        mockDelegate.expectation = expectation
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(mockUseCase.executeCalled)
        XCTAssertTrue(mockDelegate.circuitFetchedCalled)
        XCTAssertEqual(viewModel.circuit, mockCircuitDetails)
        XCTAssertEqual(mockDelegate.fetchedCircuit, mockCircuitDetails)
    }
    
    func testViewDidLoad_fetchCircuitDetailsFailure() {
        // Given
        let error = NSError(domain: "TestError", code: 0, userInfo: nil)
        mockUseCase.result = .failure(error)
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockUseCase.executeCalled)
        XCTAssertFalse(mockDelegate.circuitFetchedCalled)
        XCTAssertEqual(viewModel.circuit, [])
    }
    
    // Mock Use Case
    class MockGetCircuitDetailsUseCase: GetCircuitDetailsUseCase {
        var executeCalled = false
        var result: Result<[CircuitDetailsEntity], Error>?
        
        func execute(for circuitName: String, completion: @escaping (Result<[CircuitDetailsEntity], Error>) -> Void) -> Cancellable? {
            executeCalled = true
            if let result {
                completion(result)
            }
            return nil
        }
    }
    
    // Mock Delegate
    class MockRaceDetailViewModelDelegate: RaceDetailViewModelDelegate {
        func showLoading() {
            
        }
        
        var circuitFetchedCalled = false
        var fetchedCircuit: [CircuitDetailsEntity]?
        var expectation: XCTestExpectation?
        
        func circuitFetched(_ circuit: [CircuitDetailsEntity]) {
            circuitFetchedCalled = true
            fetchedCircuit = circuit
            expectation?.fulfill()
        }
    }
}
