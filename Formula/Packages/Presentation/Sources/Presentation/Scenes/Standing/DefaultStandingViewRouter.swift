//
//  File.swift
//  
//
//  Created by Bakar Kharabadze on 7/11/24.
//

import UIKit

class DefaultStandingViewRouter: StandingViewRouter {
    weak var view: StandingViewController?
    let driversViewControllerFactory: DriversViewControllerFactory
    let teamsViewControllerFactory: TeamsViewControllerFactory
    
    init(view: StandingViewController, driversViewControllerFactory: DriversViewControllerFactory, teamsViewControllerFactory: TeamsViewControllerFactory) {
        self.view = view
        self.driversViewControllerFactory = driversViewControllerFactory
        self.teamsViewControllerFactory = teamsViewControllerFactory
    }
    
    func perform(to route: StandingViewRoute) {
        switch route {
        case .showDriversDetail(let viewModel):
            let vc = driversViewControllerFactory.makeDriversViewController(with: viewModel)
            view?.navigationController?.pushViewController(vc, animated: true)
        case .showTeamsDetail(let viewModel):
            let vc = teamsViewControllerFactory.makeTeamsViewController(with: viewModel)
            view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
