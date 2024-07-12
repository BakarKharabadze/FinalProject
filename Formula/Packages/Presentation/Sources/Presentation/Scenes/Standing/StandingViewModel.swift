//
//  StandingViewModel.swift
//  
//
//  Created by Bakar Kharabadze on 7/11/24.
//

import Foundation
import Domain
import Common

public protocol StandingViewModelDelegate: AnyObject {
    func driversFetched(_ drivers: [DriverEntity])
    func teamsFetched(_ teams: [TeamsEntity])
}

public enum StandingViewRoute {
    case showDriversDetail(viewModel: DriversViewModel)
    case showTeamsDetail(viewModel: TeamsViewModel)
}

public protocol StandingViewRouter {
    func perform(to route: StandingViewRoute)
}

public final class StandingViewModel {
    public var router: StandingViewRouter?
    private let getDriversUseCase: GetDriversUseCase
    private let getTeamsUseCase: GetTeamsUseCase 
    weak var delegate: StandingViewModelDelegate?
    private var drivers: [DriverEntity] = []
    private var teams: [TeamsEntity] = []
    
    public init(getDriversUseCase: GetDriversUseCase, getTeamsUseCase: GetTeamsUseCase) {
        self.getDriversUseCase = getDriversUseCase
        self.getTeamsUseCase = getTeamsUseCase
    }
    
    func viewDidLoad() {
        fetchDrivers()
        fetchTeams()
    }
    
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
    
    func driversViewTapped() {
        router?.perform(to: .showDriversDetail(viewModel: DriversViewModel(drivers: drivers)))
    }
    
    func teamsViewTapped() {
        router?.perform(to: .showTeamsDetail(viewModel: TeamsViewModel(teams: teams)))
    }
}

