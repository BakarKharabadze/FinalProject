//
//  DefaultStandingViewRouter.swift
//  
//
//  Created by Bakar Kharabadze on 7/11/24.
//

import UIKit

final class DefaultStandingViewRouter: StandingViewRouter {
    
    // MARK: - Properties
    weak var view: StandingViewController?
    private let driversViewControllerFactory: DriversViewControllerFactory
    private let teamsViewControllerFactory: TeamsViewControllerFactory
    
    // MARK: - Initialization
    init(view: StandingViewController, driversViewControllerFactory: DriversViewControllerFactory, teamsViewControllerFactory: TeamsViewControllerFactory) {
        self.view = view
        self.driversViewControllerFactory = driversViewControllerFactory
        self.teamsViewControllerFactory = teamsViewControllerFactory
    }
    
    // MARK: - StandingViewRouter
    func perform(to route: StandingViewRoute) {
        switch route {
        case .showDriversDetail(let viewModel):
            let vc = driversViewControllerFactory.makeDriversViewController(with: viewModel)
            view?.navigationController?.pushViewController(vc, animated: false)
        case .showTeamsDetail(let viewModel):
            let vc = teamsViewControllerFactory.makeTeamsViewController(with: viewModel)
            view?.navigationController?.pushViewController(vc, animated: false)
        }
    }
}
