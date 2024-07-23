//
//  File.swift
//  
//
//  Created by Bakar Kharabadze on 7/19/24.
//

import XCTest
import Domain
import Common
@testable import Presentation

// Test Case
final class ScheduleViewModelTests: XCTestCase {
    
    var viewModel: ScheduleViewModel!
    var racesUseCase: MockGetRacesUseCase!
    var raceResultUseCase: MockGetRaceResultUseCase!
    var router: MockScheduleViewRouter!
    var delegate: MockScheduleViewModelDelegate!
    
    override func setUp() {
        super.setUp()
        racesUseCase = MockGetRacesUseCase()
        raceResultUseCase = MockGetRaceResultUseCase()
        router = MockScheduleViewRouter()
        delegate = MockScheduleViewModelDelegate()
        
        viewModel = ScheduleViewModel(getRacesUseCase: racesUseCase, getRaceResultUseCase: raceResultUseCase)
        viewModel.router = router
        viewModel.delegate = delegate
    }
    
    override func tearDown() {
        racesUseCase = nil
        raceResultUseCase = nil
        router = nil
        delegate = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testViewDidLoadFetchesRacesAndRaceResultsSuccessfully() {
        // Given
        let expectedRaces = [RaceEntity(
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
        )]
        let expectedRaceResults = [RaceResultEntity(
            round: "1",
            grandPrixName: "British Grand Prix",
            date: "2024-07-02",
            circuitId: "1",
            firstPlaceLastName: "Hamilton",
            secondPlaceLastName: "Verstappen",
            thirdPlaceLastName: "Norris"
        )]
        
        racesUseCase.result = .success(expectedRaces)
        raceResultUseCase.result = .success(expectedRaceResults)
        
        let racesExpectation = expectation(description: "Races fetched")
        let raceResultsExpectation = expectation(description: "Race results fetched")
        
        delegate.racesExpectation = racesExpectation
        delegate.raceResultsExpectation = raceResultsExpectation
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(delegate.fetchedRaces, expectedRaces)
        XCTAssertEqual(delegate.fetchedRaceResults, expectedRaceResults)
    }
    
    func testRaceViewTapped() {
        // Given
        let race =  RaceEntity(
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
        viewModel.upcomingRaces = [race]
        
        // When
        viewModel.raceViewTapped(race: race)
        
        // Then
        guard let performedRoute = router.performedRoute else {
            XCTFail("Expected router to perform a route, but it did not.")
            return
        }
        
        switch performedRoute {
        case .showRaceDetail(let raceDetail):
            XCTAssertEqual(raceDetail.grandPrixName, race.grandPrixName)
            XCTAssertEqual(raceDetail.date, race.date)
            XCTAssertEqual(raceDetail.round, race.round)
            XCTAssertEqual(raceDetail.circuitID, race.circuitID)
            XCTAssertEqual(raceDetail.startsIn, race.startsIn)
            XCTAssertEqual(raceDetail.countryFlag, race.countryFlag)
            XCTAssertEqual(raceDetail.image, race.image)
        }
    }
}

// Mock GetRacesUseCase
public final class MockGetRacesUseCase: GetRacesUseCase {
    var result: Result<[RaceEntity], Error>?
    
    public init() {}

    public func execute(completion: @escaping (Result<[RaceEntity], Error>) -> Void) -> Cancellable? {
        if let result = result {
            completion(result)
        }
        return nil
    }
}

// Mock GetRaceResultUseCase
public final class  MockGetRaceResultUseCase: GetRaceResultUseCase {
    var result: Result<[RaceResultEntity], Error>?
    
    public init() {}

    public func execute(completion: @escaping (Result<[RaceResultEntity], Error>) -> Void) -> Cancellable? {
        if let result = result {
            completion(result)
        }
        return nil
    }
}

// Mock Router
public final class  MockScheduleViewRouter: ScheduleViewRouter {
    var performedRoute: ScheduleViewRoute?
    
    public func perform(to route: ScheduleViewRoute) {
        performedRoute = route
    }
}

// Mock Delegate
public final class MockScheduleViewModelDelegate: ScheduleViewModelDelegate {
    var fetchedRaces: [RaceEntity]?
    var fetchedRaceResults: [RaceResultEntity]?
    var racesExpectation: XCTestExpectation?
    var raceResultsExpectation: XCTestExpectation?
    
    public func racesFetched(_ races: [RaceEntity]) {
        fetchedRaces = races
        racesExpectation?.fulfill()
    }
    
    public func raceResultFetched(_ raceResults: [RaceResultEntity]) {
        fetchedRaceResults = raceResults
        raceResultsExpectation?.fulfill()
    }
}

