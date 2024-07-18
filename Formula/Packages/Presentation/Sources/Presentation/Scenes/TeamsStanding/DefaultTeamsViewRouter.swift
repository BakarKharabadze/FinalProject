//
//  DefaultTeamsViewRouter.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import UIKit

class DefaultTeamsViewRouter: TeamsViewRouter {
    
    private weak var viewController: TeamsViewController?
    private let teamsViewControllerFactory: TeamsViewControllerFactory
    
    public init(viewController: TeamsViewController? = nil, teamsViewControllerFactory: TeamsViewControllerFactory) {
        self.viewController = viewController
        self.teamsViewControllerFactory = teamsViewControllerFactory
    }
    
    func perform(to route: TeamsViewRoute) {
        switch route {
        case .showTeamDetails(let viewModel):
            let teamDetailsVC = TeamDetailsViewController.create(with: viewModel)
            viewController?.navigationController?.pushViewController(teamDetailsVC, animated: true)
        }
    }
}
