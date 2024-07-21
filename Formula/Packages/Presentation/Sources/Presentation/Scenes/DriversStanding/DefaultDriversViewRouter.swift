//
//  DefaultDriversViewRouter.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import UIKit

final class DefaultDriversViewRouter: DriversViewRouter {
    
    // MARK: - Properties
    private weak var viewController: DriversViewController?
    private let driverViewControllerFactory: DriversViewControllerFactory
    
    // MARK: - Initialization
    init(view: DriversViewController, driversViewControllerFactory: DriversViewControllerFactory) {
        self.viewController = view
        self.driverViewControllerFactory = driversViewControllerFactory
    }
    
    // MARK: - Navigation
    func perform(to route: DriversViewRoute) {
        switch route {
        case .showDriverDetails(let viewModel):
            let driverDetailsVC = DriverDetailsViewController.create(with: viewModel)
            viewController?.navigationController?.pushViewController(driverDetailsVC, animated: true)
        }
    }
}
