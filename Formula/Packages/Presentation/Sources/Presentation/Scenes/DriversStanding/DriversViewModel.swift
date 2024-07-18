//
//  DriversViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation
import Domain

public enum DriversViewRoute {
    case showDriverDetails(viewModel: DriverDetailsViewModel)
}

public protocol DriversViewRouter {
    func perform(to route: DriversViewRoute)
}

public final class DriversViewModel {
    public var router: DriversViewRouter?
    var drivers: [DriverEntity]
    
    public init(drivers: [DriverEntity]) {
        self.drivers = drivers
    }
    
    func driverViewTapped(driver: DriverEntity) {
        let driverDetailsViewModel = DriverDetailsViewModel(driver: driver)
        router?.perform(to: .showDriverDetails(viewModel: driverDetailsViewModel))
    }
}
