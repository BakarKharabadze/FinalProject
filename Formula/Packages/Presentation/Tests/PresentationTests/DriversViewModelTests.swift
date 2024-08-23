//
//  DriversViewModelTests.swift
//
//
//  Created by Bakar Kharabadze on 7/19/24.
//

import XCTest
import Domain
import Common
@testable import Presentation

// Test case
final class DriversViewModelTests: XCTestCase {
    
    var viewModel: DriversViewModel!
    var router: MockDriversViewRouter!
    var getDriverDetailsUseCase: MockGetDriverDetailsUseCase!
    var getDriversUseCase: MockGetDriversUseCase!
    
    override func setUp() {
        super.setUp()
        router = MockDriversViewRouter()
        getDriverDetailsUseCase = MockGetDriverDetailsUseCase()
        getDriversUseCase = MockGetDriversUseCase()
        
        _ = [DriverEntity(
            driverId: "1",
            position: "1",
            givenName: "Lewis",
            familyName: "Hamilton",
            constructorName: "Mercedes",
            points: "347",
            driverImage: "image_url"
        )]
        viewModel = DriversViewModel(getDriverDetailsUseCase: getDriverDetailsUseCase, getDriversUseCase: getDriversUseCase)
        viewModel.router = router
    }
    
    override func tearDown() {
        router = nil
        viewModel = nil
        getDriverDetailsUseCase = nil
        getDriversUseCase = nil
        super.tearDown()
    }
    
    func testDriverViewTapped() {
        // Given
        let driver = DriverEntity(
            driverId: "1",
            position: "1",
            givenName: "Lewis",
            familyName: "Hamilton",
            constructorName: "Mercedes",
            points: "347",
            driverImage: "image_url"
        )
        
        // When
        viewModel.driverViewTapped(driver: driver)
        
        // Then
        guard let performedRoute = router.performedRoute else {
            XCTFail("Expected router to perform a route, but it did not.")
            return
        }
        
        switch performedRoute {
        case .showDriverDetails(let driverDetailsViewModel):
            XCTAssertEqual(driverDetailsViewModel.driver.driverId, driver.driverId)
            XCTAssertEqual(driverDetailsViewModel.driver.givenName, driver.givenName)
            XCTAssertEqual(driverDetailsViewModel.driver.familyName, driver.familyName)
            XCTAssertEqual(driverDetailsViewModel.driver.constructorName, driver.constructorName)
            XCTAssertEqual(driverDetailsViewModel.driver.points, driver.points)
            XCTAssertEqual(driverDetailsViewModel.driver.driverImage, driver.driverImage)
        }
    }
}

// Mock Router
public final class MockDriversViewRouter: DriversViewRouter {
    var performedRoute: DriversViewRoute?
    
    public func perform(to route: DriversViewRoute) {
        performedRoute = route
    }
}

// Mock UseCase
class MockGetDriverDetailsUseCase: GetDriverDetailsUseCase {
    func execute(for name: String, completion: @escaping (Result<[Domain.DriverDetailsEntity], any Error>) -> Void) -> (any Common.Cancellable)? {
        return nil
    }
}

