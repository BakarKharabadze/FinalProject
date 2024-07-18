//
//  TeamsViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation
import Domain
import UIKit

public enum TeamsViewRoute {
    case showTeamDetails(viewModel: TeamDetailsViewModel)
}

public protocol TeamsViewRouter {
    func perform(to route: TeamsViewRoute)
}

public final class TeamsViewModel {
    
    public var router: TeamsViewRouter?
    var teams: [TeamsEntity]
    
    public init(teams: [TeamsEntity]) {
        self.teams = teams
    }
    
    func teamViewTapped(team: TeamsEntity) {
        let teamDetailsViewModel = TeamDetailsViewModel(team: team)
        router?.perform(to: .showTeamDetails(viewModel: teamDetailsViewModel))
    }
}
