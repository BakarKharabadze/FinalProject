//
//  DriversViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation
import Domain

//MARK: - DriversViewRoute
public enum DriversViewRoute {
    case showDriverDetails(viewModel: DriverDetailsViewModel)
}

//MARK: - DriversViewRouter
public protocol DriversViewRouter {
    func perform(to route: DriversViewRoute)
}

//MARK: - DriversViewModel
public final class DriversViewModel {
    
    //MARK: - Properties
    public var router: DriversViewRouter?
    public var getDriverDetailsUseCase: GetDriverDetailsUseCase!
    var drivers: [DriverEntity]
    
    //MARK: - Init
    public init(router: DriversViewRouter? = nil, getDriverDetailsUseCase: GetDriverDetailsUseCase, drivers: [DriverEntity]) {
        self.router = router
        self.getDriverDetailsUseCase = getDriverDetailsUseCase
        self.drivers = drivers
    }
    
    //MARK: - Methods
    func driverViewTapped(driver: DriverEntity) {
        let driverDetailsViewModel = DriverDetailsViewModel(driver: driver, getDriverDetailsUseCase: getDriverDetailsUseCase)
        router?.perform(to: .showDriverDetails(viewModel: driverDetailsViewModel))
    }
}
