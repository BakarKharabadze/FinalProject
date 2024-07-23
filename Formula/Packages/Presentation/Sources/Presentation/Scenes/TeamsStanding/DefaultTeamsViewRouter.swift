//
//  DefaultTeamsViewRouter.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import UIKit

final class DefaultTeamsViewRouter: TeamsViewRouter {
    
    // MARK: - Properties
    private weak var viewController: TeamsViewController?
    private let teamDetailsViewControllerFactory: TeamDetailsViewControllerFactory
    
    // MARK: - Initialization
    public init(viewController: TeamsViewController? = nil, teamDetailsViewControllerFactory: TeamDetailsViewControllerFactory) {
        self.viewController = viewController
        self.teamDetailsViewControllerFactory = teamDetailsViewControllerFactory
    }
    
    // MARK: - Navigation
    func perform(to route: TeamsViewRoute) {
        switch route {
        case .showTeamDetails(let viewModel):
            let teamDetailsVC = TeamDetailsViewController.create(with: viewModel)
            viewController?.navigationController?.pushViewController(teamDetailsVC, animated: true)
        }
    }
}


