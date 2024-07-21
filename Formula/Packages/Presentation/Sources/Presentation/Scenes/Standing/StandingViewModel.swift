//
//  StandingViewModel.swift
//  
//
//  Created by Bakar Kharabadze on 7/11/24.
//

import Foundation
import Domain
import Common

// MARK: - Protocols
public protocol StandingViewModelDelegate: AnyObject {
    func driversFetched(_ drivers: [DriverEntity])
    func teamsFetched(_ teams: [TeamsEntity])
}

//MARK: - StandingViewRoute
public enum StandingViewRoute {
    case showDriversDetail(viewModel: DriversViewModel)
    case showTeamsDetail(viewModel: TeamsViewModel)
}

//MARK: - StandingViewRouter
public protocol StandingViewRouter {
    func perform(to route: StandingViewRoute)
}

// MARK: - ViewModel
public final class StandingViewModel {
    
    // MARK: - Properties
    public var router: StandingViewRouter?
    private let getDriversUseCase: GetDriversUseCase
    private let getTeamsUseCase: GetTeamsUseCase
    public weak var delegate: StandingViewModelDelegate?
    var drivers: [DriverEntity] = []
    var teams: [TeamsEntity] = []
    
    // MARK: - Initialization
    public init(getDriversUseCase: GetDriversUseCase, getTeamsUseCase: GetTeamsUseCase) {
        self.getDriversUseCase = getDriversUseCase
        self.getTeamsUseCase = getTeamsUseCase
    }
    
    // MARK: - Public Methods
    func viewDidLoad() {
        fetchDrivers()
        fetchTeams()
    }
    
    func driversViewTapped() {
        router?.perform(to: .showDriversDetail(viewModel: DriversViewModel(drivers: drivers)))
    }
    
    func teamsViewTapped() {
        router?.perform(to: .showTeamsDetail(viewModel: TeamsViewModel(teams: teams)))
    }
    
    // MARK: - Private Methods
    private func fetchDrivers() {
        getDriversUseCase.execute { [weak self] result in
            switch result {
            case .success(let drivers):
                self?.drivers = drivers
                DispatchQueue.main.async {
                    self?.delegate?.driversFetched(drivers)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchTeams() {
        getTeamsUseCase.execute { [weak self] result in
            switch result {
            case .success(let teams):
                self?.teams = teams
                DispatchQueue.main.async {
                    self?.delegate?.teamsFetched(teams)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
