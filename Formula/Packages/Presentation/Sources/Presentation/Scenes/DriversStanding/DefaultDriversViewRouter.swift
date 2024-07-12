//
//  DefaultDriversViewRouter.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import UIKit

class DefaultDriversViewRouter: StandingViewRouter {
    
    private weak var viewController: DriversViewController?
    private let driverViewControllerFactory: DriversViewControllerFactory
    
    init(view: DriversViewController, driversViewControllerFactory: DriversViewControllerFactory) {
        self.viewController = view
        self.driverViewControllerFactory = driversViewControllerFactory
    }
    
    func perform(to: StandingViewRoute) {
    }
}
