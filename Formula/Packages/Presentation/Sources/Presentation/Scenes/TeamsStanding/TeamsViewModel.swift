//
//  TeamsViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation
import Domain
import UIKit

//MARK: - TeamsViewRoute
public enum TeamsViewRoute {
    case showTeamDetails(viewModel: TeamDetailsViewModel)
}

//MARK: - TeamsViewRouter
public protocol TeamsViewRouter {
    func perform(to route: TeamsViewRoute)
}

public final class TeamsViewModel {
    
    //MARK: - Properties
    public var router: TeamsViewRouter?
    var teams: [TeamsEntity]
    
    //MARK: - Init
    public init(teams: [TeamsEntity]) {
        self.teams = teams
    }
    
    //MARK: - Methods
    func teamViewTapped(team: TeamsEntity) {
        let teamDetailsViewModel = TeamDetailsViewModel(team: team)
        router?.perform(to: .showTeamDetails(viewModel: teamDetailsViewModel))
    }
}
