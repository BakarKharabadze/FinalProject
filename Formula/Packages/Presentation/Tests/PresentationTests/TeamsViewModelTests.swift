//
//  TeamsViewModelTests.swift
//
//
//  Created by Bakar Kharabadze on 7/19/24.
//

import XCTest
import Domain
import UIKit
import Common
@testable import Presentation

// Test Case
final class TeamsViewModelTests: XCTestCase {
    
    var viewModel: TeamsViewModel!
    var router: MockTeamsViewRouter!
    var getTeamDetailsUseCase: MockGetTeamDetailsUseCase!
    var getTeamsUseCase: MockGetTeamsUseCase!
    
    override func setUp() {
        super.setUp()
        router = MockTeamsViewRouter()
        getTeamDetailsUseCase = MockGetTeamDetailsUseCase()
        getTeamsUseCase = MockGetTeamsUseCase()
        viewModel = TeamsViewModel(getTeamDetailsUseCase: getTeamDetailsUseCase, getTeamsUseCase: getTeamsUseCase)
        viewModel.router = router
    }
    
    override func tearDown() {
        router = nil
        viewModel = nil
        getTeamDetailsUseCase = nil
        getTeamsUseCase = nil 
        super.tearDown()
    }
    
    func testTeamViewTapped() {
        // მოცემული
        let team = TeamsEntity(
            position: "1",
            constructorName: "Team A",
            points: "500",
            nationality: "British",
            liveryImage: "team_a_image",
            constructorID: "team_a_id"
        )
        
        // როდესაც
        viewModel.teamViewTapped(team: team)
        
        // მაშინ
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
public final class MockTeamsViewRouter: TeamsViewRouter {
    
    var performedRoute: TeamsViewRoute?
    
    public func perform(to route: TeamsViewRoute) {
        performedRoute = route
    }
}

// Mock UseCase
class MockGetTeamDetailsUseCase: GetTeamDetailsUseCase {
    func execute(for teamName: String, completion: @escaping (Result<[Domain.TeamDetailsEntity], any Error>) -> Void) -> (any Common.Cancellable)? {
        return nil
    }
}

