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
    private let driverDetailsVIewControllerFactory: DriverDetailsViewControllerFactory
    
    // MARK: - Initialization
    init(view: DriversViewController, driverDetailsVIewControllerFactory: DriverDetailsViewControllerFactory) {
        self.viewController = view
        self.driverDetailsVIewControllerFactory = driverDetailsVIewControllerFactory
    }
    
    // MARK: - Navigation
    func perform(to route: DriversViewRoute) {
        switch route {
        case .showDriverDetails(let DriverEntity):
            let driverDetailsVC = driverDetailsVIewControllerFactory.makeDriverDetailsViewController(for: DriverEntity)
            viewController?.navigationController?.pushViewController(driverDetailsVC, animated: true)
        }
    }
}

