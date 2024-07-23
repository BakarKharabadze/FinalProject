//
//  TeamDetailsViewModelTests.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import XCTest
import Domain
import Common
@testable import Presentation

class TeamDetailsViewModelTests: XCTestCase {
    
    // Properties
    var viewModel: TeamDetailsViewModel!
    var mockUseCase: MockGetTeamDetailsUseCase!
    var mockDelegate: MockTeamDetailsViewModelDelegate!
    
    // Mock Data
    let mockTeam = TeamsEntity(
        position: "1",
        constructorName: "Mercedes",
        points: "573",
        nationality: "German",
        liveryImage: "livery_url",
        constructorID: "1"
    )
    
    let mockTeamDetails = [
        TeamDetailsEntity(
            name: "Mercedes",
            worldTitle: "8",
            raceWins: "100",
            polePositions: "80",
            fastesLaps: "70",
            base: "Brackley, United Kingdom",
            president: "Toto Wolff",
            director: "James Allison",
            technicalManeger: "Mike Elliott", 
            logo: ""
        )
    ]
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockGetTeamDetailsUseCase()
        mockDelegate = MockTeamDetailsViewModelDelegate()
        viewModel = TeamDetailsViewModel(getTeamDetailsUseCase: mockUseCase, team: mockTeam)
        viewModel.delegate = mockDelegate
    }
    
    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func testViewDidLoad_fetchesTeamDetailsSuccessfully() {
        // Given
        mockUseCase.result = .success(mockTeamDetails)
        let expectation = self.expectation(description: "Team details fetched")
        mockDelegate.expectation = expectation
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(mockUseCase.executeCalled)
        XCTAssertTrue(mockDelegate.teamDetailsFetchedCalled)
        XCTAssertEqual(viewModel.teamDetails, mockTeamDetails)
        XCTAssertEqual(mockDelegate.fetchedTeamDetails, mockTeamDetails)
    }
    
    func testViewDidLoad_fetchTeamDetailsFailure() {
        // Given
        let error = NSError(domain: "TestError", code: 0, userInfo: nil)
        mockUseCase.result = .failure(error)
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockUseCase.executeCalled)
        XCTAssertFalse(mockDelegate.teamDetailsFetchedCalled)
        XCTAssertEqual(viewModel.teamDetails, [])
    }
    
    // Mock Use Case
    class MockGetTeamDetailsUseCase: GetTeamDetailsUseCase {
        var executeCalled = false
        var result: Result<[TeamDetailsEntity], Error>?
        
        func execute(for teamName: String, completion: @escaping (Result<[TeamDetailsEntity], Error>) -> Void) -> Cancellable? {
            executeCalled = true
            if let result {
                completion(result)
            }
            return nil
        }
    }
    
    // Mock Delegate
    class MockTeamDetailsViewModelDelegate: TeamDetailsViewModelDelegate {
        
        var teamDetailsFetchedCalled = false
        var fetchedTeamDetails: [TeamDetailsEntity]?
        var expectation: XCTestExpectation?
        
        func teamDetailsFetched(_ teamDetails: [TeamDetailsEntity], logoData: Data?) {
            teamDetailsFetchedCalled = true
            fetchedTeamDetails = teamDetails
            expectation?.fulfill()
        }
    }
}
