//
//  StandingViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/11/24.
//

import Foundation
import Domain
import Common

// MARK: - StandingViewModelDelegate
public protocol StandingViewModelDelegate: AnyObject {
    func driversFetched(_ drivers: [DriverEntity])
    func teamsFetched(_ teams: [TeamsEntity])
    func showLoading()
    func hideLoading()
    func showError(message: String)
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

// MARK: - StandingViewModel
public final class StandingViewModel {
    
    // MARK: - Properties
    public var router: StandingViewRouter?
    private let getDriversUseCase: GetDriversUseCase
    private let getTeamsUseCase: GetTeamsUseCase
    private let getDriverDetailsUseCase: GetDriverDetailsUseCase
    private let getTeamDetailsUseCase: GetTeamDetailsUseCase
    public weak var delegate: StandingViewModelDelegate?
    var drivers: [DriverEntity] = []
    var teams: [TeamsEntity] = []
    
    // MARK: - Initialization
    public init(getDriversUseCase: GetDriversUseCase, getTeamsUseCase: GetTeamsUseCase, getDriverDetailsUseCase: GetDriverDetailsUseCase, getTeamDetailsUseCase: GetTeamDetailsUseCase) {
        self.getDriversUseCase = getDriversUseCase
        self.getTeamsUseCase = getTeamsUseCase
        self.getDriverDetailsUseCase = getDriverDetailsUseCase
        self.getTeamDetailsUseCase = getTeamDetailsUseCase
    }
    
    // MARK: - Public Methods
    func viewDidLoad() {
        delegate?.showLoading()
        fetchDrivers()
        fetchTeams()
    }
    
    func driversViewTapped() {
        let driversViewModel = DriversViewModel(getDriverDetailsUseCase: getDriverDetailsUseCase, getDriversUseCase: getDriversUseCase)
        router?.perform(to: .showDriversDetail(viewModel: driversViewModel))
    }
    
    func teamsViewTapped() {
        let teamsViewModel = TeamsViewModel(getTeamDetailsUseCase: getTeamDetailsUseCase, getTeamsUseCase: getTeamsUseCase)
        router?.perform(to: .showTeamsDetail(viewModel: teamsViewModel))
    }
    
    // MARK: - Private Methods
    private func fetchDrivers() {
        _ = getDriversUseCase.execute { [weak self] result in
            guard let self = self else { return }
            self.delegate?.hideLoading()
            switch result {
            case .success(let drivers):
                self.drivers = drivers
                DispatchQueue.main.async {
                    self.delegate?.driversFetched(drivers)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.showError(message: "Failed to load drivers. Please try again.")
                }
                print(error)
            }
        }
    }
    
    private func fetchTeams() {
        _ = getTeamsUseCase.execute { [weak self] result in
            guard let self = self else { return }
            self.delegate?.hideLoading()
            switch result {
            case .success(let teams):
                self.teams = teams
                DispatchQueue.main.async {
                    self.delegate?.teamsFetched(teams)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.showError(message: "Failed to load teams. Please try again.")
                }
                print(error)
            }
        }
    }
}
