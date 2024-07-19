//
//  TeamsViewModelTests.swift
//
//
//  Created by Bakar Kharabadze on 7/19/24.
//

import XCTest
import Domain
import UIKit
@testable import Presentation

// Test Case
class TeamsViewModelTests: XCTestCase {
    
    var viewModel: TeamsViewModel!
    var router: MockTeamsViewRouter!
    
    override func setUp() {
        super.setUp()
        router = MockTeamsViewRouter()
        let teams = [TeamsEntity(
            position: "",
            constructorName: "",
            points: "",
            nationality: "",
            liveryImage: ""
        )]
        viewModel = TeamsViewModel(teams: teams)
        viewModel.router = router
    }
    
    override func tearDown() {
        router = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testTeamViewTapped() {
        // Given
        let team = TeamsEntity(
            position: "",
            constructorName: "",
            points: "",
            nationality: "",
            liveryImage: ""
        )
        
        // When
        viewModel.teamViewTapped(team: team)
        
        // Then
        guard let performedRoute = router.performedRoute else {
            XCTFail("Expected router to perform a route, but it did not.")
            return
        }
        
        switch performedRoute {
        case .showTeamDetails(let viewModel):
            XCTAssertEqual(viewModel.team.constructorName, team.constructorName)
        }
    }
}


// Mock Router
public class MockTeamsViewRouter: TeamsViewRouter {
    
    var performedRoute: TeamsViewRoute?
    
    public func perform(to route: TeamsViewRoute) {
        performedRoute = route
    }
}
