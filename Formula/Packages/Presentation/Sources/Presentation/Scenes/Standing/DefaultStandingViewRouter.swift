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
        case .showDriversDetail(let driverEntity):
            let vc = driversViewControllerFactory.makeDriversViewController(for: driverEntity)
            view?.navigationController?.pushViewController(vc, animated: false)
        case .showTeamsDetail(let teamsEntity):
            let vc = teamsViewControllerFactory.makeTeamsViewController(for: teamsEntity)
            view?.navigationController?.pushViewController(vc, animated: false)
        }
    }
}
