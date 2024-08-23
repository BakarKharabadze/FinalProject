//
//  DriversViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation
import Domain

// MARK: - DriversViewModelDelegate
public protocol DriversViewModelDelegate: AnyObject {
    func driversFetched(_ drivers: [DriverEntity])
    func showLoading()
    func hideLoading()
    func showError(message: String)
}

// MARK: - DriversViewRoute
public enum DriversViewRoute {
    case showDriverDetails(for: DriverEntity)
}

// MARK: - DriversViewRouter
public protocol DriversViewRouter {
    func perform(to route: DriversViewRoute)
}

// MARK: - DriversViewModel
public final class DriversViewModel {
    
    // MARK: - Properties
    public var router: DriversViewRouter?
    public var getDriverDetailsUseCase: GetDriverDetailsUseCase!
    public var getDriversUseCase: GetDriversUseCase!
    var drivers: [DriverEntity] = []
    public weak var delegate: DriversViewModelDelegate?
    
    // MARK: - Init
    public init(router: DriversViewRouter? = nil, getDriverDetailsUseCase: GetDriverDetailsUseCase, getDriversUseCase: GetDriversUseCase) {
        self.router = router
        self.getDriverDetailsUseCase = getDriverDetailsUseCase
        self.getDriversUseCase = getDriversUseCase
    }
    
    // MARK: - Methods
    func driverViewTapped(driver: DriverEntity) {
        router?.perform(to: .showDriverDetails(for: driver))
    }
    
    func fetchDrivers() {
        guard let delegate = delegate else {
            print("Delegate is not set")
            return
        }
        delegate.showLoading()
        _ = getDriversUseCase.execute { [weak self] result in
            guard let self = self else { return }
            delegate.hideLoading()
            switch result {
            case .success(let drivers):
                self.drivers = drivers
                DispatchQueue.main.async {
                    delegate.driversFetched(drivers)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    delegate.showError(message: "Failed to load drivers. Please try again.")
                }
                print(error)
            }
        }
    }
}
