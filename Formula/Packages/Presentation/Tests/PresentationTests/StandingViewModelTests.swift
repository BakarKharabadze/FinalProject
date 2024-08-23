//
//  StandingViewModelTests.swift
//
//
//  Created by Bakar Kharabadze on 7/19/24.
//

import XCTest
import Domain
import Common
@testable import Presentation

// Test Case
final class StandingViewModelTests: XCTestCase {
    
    var viewModel: StandingViewModel!
    var driversUseCase: MockGetDriversUseCase!
    var teamsUseCase: MockGetTeamsUseCase!
    var getDriverDetailsUseCase: MockGetDriversDetailsUseCase!
    var getTeamDetailsUseCase: MockGetTeamsDetailsUseCase!
    var router: MockStandingViewRouter!
    var delegate: MockStandingViewModelDelegate!
    
    override func setUp() {
        super.setUp()
        driversUseCase = MockGetDriversUseCase()
        teamsUseCase = MockGetTeamsUseCase()
        getDriverDetailsUseCase = MockGetDriversDetailsUseCase()
        getTeamDetailsUseCase = MockGetTeamsDetailsUseCase()
        router = MockStandingViewRouter()
        delegate = MockStandingViewModelDelegate()
        
        viewModel = StandingViewModel(
            getDriversUseCase: driversUseCase,
            getTeamsUseCase: teamsUseCase,
            getDriverDetailsUseCase: getDriverDetailsUseCase,
            getTeamDetailsUseCase: getTeamDetailsUseCase
        )
        viewModel.router = router
        viewModel.delegate = delegate
    }
    
    override func tearDown() {
        driversUseCase = nil
        teamsUseCase = nil
        getDriverDetailsUseCase = nil
        getTeamDetailsUseCase = nil
        router = nil
        delegate = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testViewDidLoadFetchesDriversAndTeamsSuccessfully() {
        // Given
        let expectedDrivers = [DriverEntity(driverId: "1", position: "1", givenName: "Lewis", familyName: "Hamilton", constructorName: "Mercedes", points: "347", driverImage: "image_url")]
        let expectedTeams = [TeamsEntity(position: "1", constructorName: "Mercedes", points: "573", nationality: "German", liveryImage: "livery_url", constructorID: "1")]
        
        driversUseCase.result = .success(expectedDrivers)
        teamsUseCase.result = .success(expectedTeams)
        
        let driversExpectation = expectation(description: "Drivers fetched")
        let teamsExpectation = expectation(description: "Teams fetched")
        
        delegate.driversExpectation = driversExpectation
        delegate.teamsExpectation = teamsExpectation
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(delegate.fetchedDrivers, expectedDrivers)
        XCTAssertEqual(delegate.fetchedTeams, expectedTeams)
    }
    
    func testDriversViewTapped() {
        // Given
        let drivers = [DriverEntity(driverId: "1", position: "1", givenName: "Lewis", familyName: "Hamilton", constructorName: "Mercedes", points: "347", driverImage: "image_url")]
        viewModel.drivers = drivers
        
        // When
        viewModel.driversViewTapped()
        
        // Then
        guard let performedRoute = router.performedRoute else {
            XCTFail("Expected router to perform a route, but it did not.")
            return
        }
        
        switch performedRoute {
        case .showDriversDetail(let driversViewModel):
            XCTAssertEqual(driversViewModel.drivers, drivers)
        case .showTeamsDetail:
            XCTFail("Expected showDriversDetail route, but got showTeamsDetail")
        }
    }
    
    func testTeamsViewTapped() {
        // Given
        let teams = [TeamsEntity(position: "1", constructorName: "Mercedes", points: "573", nationality: "German", liveryImage: "livery_url", constructorID: "1")]
        viewModel.teams = teams
        
        // When
        viewModel.teamsViewTapped()
        
        // Then
        guard let performedRoute = router.performedRoute else {
            XCTFail("Expected router to perform a route, but it did not.")
            return
        }
        
        switch performedRoute {
        case .showTeamsDetail(let teamsViewModel):
            XCTAssertEqual(teamsViewModel.teams, teams)
        case .showDriversDetail:
            XCTFail("Expected showTeamsDetail route, but got showDriversDetail")
        }
    }
}


// Mock GetDriversUseCase
public final class MockGetDriversUseCase: GetDriversUseCase {
    var result: Result<[DriverEntity], Error>?
    
    public init() {}

    public func execute(completion: @escaping (Result<[DriverEntity], Error>) -> Void) -> Cancellable? {
        if let result = result {
            completion(result)
        }
        return nil
    }
}

// Mock GetTeamsUseCase
public final class MockGetTeamsUseCase: GetTeamsUseCase {
    var result: Result<[TeamsEntity], Error>?
    
    public init() {}

    public func execute(completion: @escaping (Result<[TeamsEntity], Error>) -> Void) -> Cancellable? {
        if let result = result {
            completion(result)
        }
        return nil
    }
}

// Mock GetDriverDetailsUseCase
public final class MockGetDriversDetailsUseCase: GetDriverDetailsUseCase {
    public init() {}
    
    public func execute(for name: String, completion: @escaping (Result<[DriverDetailsEntity], Error>) -> Void) -> Cancellable? {
        // Implement mock functionality here
        return nil
    }
}

// Mock GetTeamDetailsUseCase
public final class MockGetTeamsDetailsUseCase: GetTeamDetailsUseCase {
    public init() {}
    
    public func execute(for name: String, completion: @escaping (Result<[TeamDetailsEntity], Error>) -> Void) -> Cancellable? {
        // Implement mock functionality here
        return nil
    }
}

// Mock Router
public final class MockStandingViewRouter: StandingViewRouter {
    var performedRoute: StandingViewRoute?
    
    public func perform(to route: StandingViewRoute) {
        performedRoute = route
    }
}

// Mock Delegate
public final class MockStandingViewModelDelegate: StandingViewModelDelegate {
    public func showLoading() {
        
    }
    
    public func hideLoading() {
        
    }
    
    public func showError(message: String) {
        
    }
    
    var fetchedDrivers: [DriverEntity]?
    var fetchedTeams: [TeamsEntity]?
    var driversExpectation: XCTestExpectation?
    var teamsExpectation: XCTestExpectation?
    
    public func driversFetched(_ drivers: [DriverEntity]) {
        fetchedDrivers = drivers
        driversExpectation?.fulfill()
    }
    
    public func teamsFetched(_ teams: [TeamsEntity]) {
        fetchedTeams = teams
        teamsExpectation?.fulfill()
    }
}
