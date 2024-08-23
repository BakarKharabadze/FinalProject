//
//  HomeViewModelTests.swift
//
//
//  Created by Bakar Kharabadze on 7/23/24.
//

import XCTest
import Domain
import Common
@testable import Presentation

class HomeViewModelTests: XCTestCase {
    
    // Mock Entities
    let mockNews = [NewsEntity(
        title: "News Title",
        description: "News Description",
        url: "https://newsurl.com",
        urlToImage: "https://newsimage.com",
        publishedAt: "2023-07-23T12:34:56Z",
        content: "News Content"
    )]
    
    let mockDrivers = [DriverEntity(
        driverId: "1",
        position: "1",
        givenName: "John",
        familyName: "Doe",
        constructorName: "Constructor",
        points: "100",
        driverImage: "https://driverimage.com"
    )]
    
    let mockRaces = [RaceEntity(
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

    // Tests
    func testViewDidLoad_fetchesNewsDriversAndUpcomingRace() {
        let newsUseCase = MockGetNewsUseCase()
        let driversUseCase = MockGetDriversUseCase()
        let racesUseCase = MockGetRacesUseCase()
        let viewModel = HomeViewModel(getNewsUseCase: newsUseCase, getDriversUseCase: driversUseCase, getUpcomingRacesUseCase: racesUseCase)
        
        viewModel.viewDidLoad()
        
        XCTAssertTrue(newsUseCase.executeCalled)
        XCTAssertTrue(driversUseCase.executeCalled)
        XCTAssertTrue(racesUseCase.executeCalled)
    }
    
    func testFetchNews_success() {
        let newsUseCase = MockGetNewsUseCase()
        let driversUseCase = MockGetDriversUseCase()
        let racesUseCase = MockGetRacesUseCase()
        let delegate = MockHomeViewModelDelegate()
        let viewModel = HomeViewModel(getNewsUseCase: newsUseCase, getDriversUseCase: driversUseCase, getUpcomingRacesUseCase: racesUseCase)
        viewModel.delegate = delegate
        
        let expectation = self.expectation(description: "FetchNews")
        
        newsUseCase.result = .success(mockNews)
        
        viewModel.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(delegate.newsFetchedCalled)
            XCTAssertEqual(viewModel.news, self.mockNews)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testFetchDrivers_success() {
        let newsUseCase = MockGetNewsUseCase()
        let driversUseCase = MockGetDriversUseCase()
        let racesUseCase = MockGetRacesUseCase()
        let delegate = MockHomeViewModelDelegate()
        let viewModel = HomeViewModel(getNewsUseCase: newsUseCase, getDriversUseCase: driversUseCase, getUpcomingRacesUseCase: racesUseCase)
        viewModel.delegate = delegate
        
        let expectation = self.expectation(description: "FetchDrivers")
        
        driversUseCase.result = .success(mockDrivers)
        
        viewModel.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(delegate.driversFetchedCalled)
            XCTAssertEqual(viewModel.drivers, self.mockDrivers)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testFetchUpcomingRace_success() {
        let newsUseCase = MockGetNewsUseCase()
        let driversUseCase = MockGetDriversUseCase()
        let racesUseCase = MockGetRacesUseCase()
        let delegate = MockHomeViewModelDelegate()
        let viewModel = HomeViewModel(getNewsUseCase: newsUseCase, getDriversUseCase: driversUseCase, getUpcomingRacesUseCase: racesUseCase)
        viewModel.delegate = delegate
        
        racesUseCase.result = .success(mockRaces)
        
        viewModel.viewDidLoad()
}
    
    func testNewsViewTapped_navigatesToNewsDetail() {
        class MockRouter: HomeViewRouter {
            var performCalled = false
            var route: HomeViewRoute?
            
            func perform(to: HomeViewRoute) {
                performCalled = true
                route = to
            }
        }
        
        let newsUseCase = MockGetNewsUseCase()
        let driversUseCase = MockGetDriversUseCase()
        let racesUseCase = MockGetRacesUseCase()
        let router = MockRouter()
        let viewModel = HomeViewModel(getNewsUseCase: newsUseCase, getDriversUseCase: driversUseCase, getUpcomingRacesUseCase: racesUseCase)
        viewModel.router = router
        
        let news = mockNews[0]
        viewModel.newsViewTapped(news: news)
        
        XCTAssertTrue(router.performCalled)
        XCTAssertEqual(router.route, .showNewsDetail)
        XCTAssertEqual(viewModel.selectedNews, news)
    }
    
    // Mock Classes
    class MockGetNewsUseCase: GetNewsUseCase {
        var executeCalled = false
        var result: Result<[NewsEntity], Error>?
        
        func execute(query: String, from: String, sortBy: String, language: String, apiKey: String, completion: @escaping (Result<[NewsEntity], Error>) -> Void) -> Cancellable? {
            executeCalled = true
            if let result {
                completion(result)
            }
            return nil
        }
    }
    
    class MockGetDriversUseCase: GetDriversUseCase {
        var executeCalled = false
        var result: Result<[DriverEntity], Error>?
        
        func execute(completion: @escaping (Result<[DriverEntity], Error>) -> Void) -> Cancellable? {
            executeCalled = true
            if let result {
                completion(result)
            }
            return nil
        }
    }
    
    class MockGetRacesUseCase: GetRacesUseCase {
        var executeCalled = false
        var result: Result<[RaceEntity], Error>?
        
        func execute(completion: @escaping (Result<[RaceEntity], Error>) -> Void) -> Cancellable? {
            executeCalled = true
            if let result {
                completion(result)
            }
            return nil
        }
    }
    
    class MockHomeViewModelDelegate: HomeViewModelDelegate {
        func errorOccurred(_ error: any Error) {
            
        }
        
        var newsFetchedCalled = false
        var driversFetchedCalled = false
        var raceFetchedCalled = false
        
        func newsFetched(_ news: [NewsEntity]) {
            newsFetchedCalled = true
        }
        
        func driversFetched(_ drivers: [DriverEntity]) {
            driversFetchedCalled = true
        }
        
        func raceFetched(_ race: RaceEntity) {
            raceFetchedCalled = true
        }
    }
}

