//
//  TeamsViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation
import Domain

// MARK: - TeamsViewModelDelegate
public protocol TeamsViewModelDelegate: AnyObject {
    func teamsFetched(_ teams: [TeamsEntity])
    func showLoading()
    func hideLoading()
    func showError(message: String)
}

// MARK: - TeamsViewRoute
public enum TeamsViewRoute {
    case showTeamDetails(viewModel: TeamDetailsViewModel)
}

// MARK: - TeamsViewRouter
public protocol TeamsViewRouter {
    func perform(to route: TeamsViewRoute)
}

// MARK: - TeamsViewModel
public final class TeamsViewModel {
    
    // MARK: - Properties
    public var router: TeamsViewRouter?
    public var getTeamDetailsUseCase: GetTeamDetailsUseCase!
    public var getTeamsUseCase: GetTeamsUseCase!
    var teams: [TeamsEntity] = []
    public weak var delegate: TeamsViewModelDelegate?
    
    // MARK: - Init
    public init(router: TeamsViewRouter? = nil, getTeamDetailsUseCase: GetTeamDetailsUseCase, getTeamsUseCase: GetTeamsUseCase) {
        self.router = router
        self.getTeamDetailsUseCase = getTeamDetailsUseCase
        self.getTeamsUseCase = getTeamsUseCase
    }
    
    // MARK: - Methods
    func teamViewTapped(team: TeamsEntity) {
        let teamDetailsViewModel = TeamDetailsViewModel(getTeamDetailsUseCase: getTeamDetailsUseCase, team: team)
        router?.perform(to: .showTeamDetails(viewModel: teamDetailsViewModel))
    }
    
    func fetchTeams() {
        guard let delegate = delegate else {
            print("Delegate is not set")
            return
        }
        delegate.showLoading()
        _ = getTeamsUseCase.execute { [weak self] result in
            guard let self = self else { return }
            delegate.hideLoading()
            switch result {
            case .success(let teams):
                self.teams = teams
                DispatchQueue.main.async {
                    delegate.teamsFetched(teams)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    delegate.showError(message: "Failed to load teams. Please try again.")
                }
                print(error)
            }
        }
    }
}
