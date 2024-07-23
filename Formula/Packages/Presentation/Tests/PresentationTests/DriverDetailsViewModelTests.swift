//
//  DriverDetailsViewModelTests.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import XCTest
import Domain
import Common
@testable import Presentation

class DriverDetailsViewModelTests: XCTestCase {
    
    // Properties
    var viewModel: DriverDetailsViewModel!
    var mockUseCase: MockGetDriverDetailsUseCase!
    var mockDelegate: MockDriverDetailsViewModelDelegate!
    
    // Mock Data
    let mockDriver = DriverEntity(
        driverId: "1",
        position: "1",
        givenName: "Lewis",
        familyName: "Hamilton",
        constructorName: "Mercedes",
        points: "347",
        driverImage: "image_url"
    )
    
    let mockDriverDetails = [
        DriverDetailsEntity(
            name: "Lewis Hamilton",
            driverNumber: "44",
            teamName: "Mercedes",
            races: "250",
            worldTitle: "7",
            raceWins: "100",
            podiums: "150",
            nationality: "British",
            birthday: "1985-01-07",
            birthPlace: "Stevenage, England"
        )
    ]
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockGetDriverDetailsUseCase()
        mockDelegate = MockDriverDetailsViewModelDelegate()
        viewModel = DriverDetailsViewModel(driver: mockDriver, getDriverDetailsUseCase: mockUseCase)
        viewModel.delegate = mockDelegate
    }
    
    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func testViewDidLoad_fetchesDriverDetailsSuccessfully() {
        // Given
        mockUseCase.result = .success(mockDriverDetails)
        let expectation = self.expectation(description: "Driver details fetched")
        mockDelegate.expectation = expectation
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(mockUseCase.executeCalled)
        XCTAssertTrue(mockDelegate.driverDetailsFetchedCalled)
        XCTAssertEqual(viewModel.driverDetails, mockDriverDetails)
        XCTAssertEqual(mockDelegate.fetchedDriverDetails, mockDriverDetails)
    }
    
    func testViewDidLoad_fetchDriverDetailsFailure() {
        // Given
        let error = NSError(domain: "TestError", code: 0, userInfo: nil)
        mockUseCase.result = .failure(error)
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockUseCase.executeCalled)
        XCTAssertFalse(mockDelegate.driverDetailsFetchedCalled)
        XCTAssertEqual(viewModel.driverDetails, [])
    }
    
    // Mock Use Case
    class MockGetDriverDetailsUseCase: GetDriverDetailsUseCase {
        var executeCalled = false
        var result: Result<[DriverDetailsEntity], Error>?
        
        func execute(for name: String, completion: @escaping (Result<[DriverDetailsEntity], Error>) -> Void) -> Cancellable? {
            executeCalled = true
            if let result {
                completion(result)
            }
            return nil
        }
    }
    
    // Mock Delegate
    class MockDriverDetailsViewModelDelegate: DriverDetailsViewModelDelegate {
        var driverDetailsFetchedCalled = false
        var fetchedDriverDetails: [DriverDetailsEntity]?
        var expectation: XCTestExpectation?
        
        func driverDetailsFetched(_ driverDetails: [DriverDetailsEntity]) {
            driverDetailsFetchedCalled = true
            fetchedDriverDetails = driverDetails
            expectation?.fulfill()
        }
    }
    
}
