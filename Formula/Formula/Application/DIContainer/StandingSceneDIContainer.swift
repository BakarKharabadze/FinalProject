//
//  StandingSceneDIContainer.swift
//  Formula
//
//  Created by Bakar Kharabadze on 7/11/24.
//

import UIKit
import Domain
import Presentation
import Network
import Data

final class StandingSceneDIContainer {
    
    //MARK: - Dependencies
    struct Dependencies {
        let formulaApiDataTransferService: DataTransfer
        let driverViewControllerFactory: DriversViewControllerFactory
        let teamsViewControllerFactory: TeamsViewControllerFactory
        let formulaSportApiDataTransferService: DataTransfer
    }
    
    //MARK: - Properties
    private let dependencies: Dependencies
    
    //MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

//MARK: - Use Cases
extension StandingSceneDIContainer {
    func makeGetDriversUseCase() -> GetDriversUseCase {
        DefaultGetDriversUseCase(repository: makeDriverRepository())
    }
    
    func makeGetTeamsUseCase() -> GetTeamsUseCase {
        DefaultGetTeamsUseCase(repository: makeTeamsRepository())
    }
    
    func makeGetDriverDetailsUseCase() -> GetDriverDetailsUseCase {
        DefaultGetDriversDetailsUseCase(repository: makeDriverDetailsRepository())
    }
    
    func makeGetTeamDetailsUseCase() -> GetTeamDetailsUseCase {
        DefaultGetTeamDetailsUseCase(repository: makeTeamDetailsRepository())
    }
}

//MARK: - Repository
extension StandingSceneDIContainer {
    func makeDriverRepository() -> DriversRepository {
        DefaultDriversRepository(dataTransferService: dependencies.formulaApiDataTransferService)
    }
    
    func makeTeamsRepository() -> TeamsRepository {
        DefaultTeamsRepository(dataTransferService: dependencies.formulaApiDataTransferService)
    }
    
    func makeDriverDetailsRepository() -> DriverDetailsRepository {
        DefaultDriverDetailsRepository(dataTransferService: dependencies.formulaSportApiDataTransferService)
    }
    
    func makeTeamDetailsRepository() -> TeamDetailsRepository {
        DefaultTeamDetailsRepository(dataTransferService: dependencies.formulaSportApiDataTransferService)
    }
}

//MARK: - StandingSceneDIContainer Factory
extension StandingSceneDIContainer: StandingViewControllerFactory {
    func makeStandingViewController() -> UIViewController {
        return StandingViewController.create(
            with: makeStandingViewModel(),
            driversViewControllerFactory: dependencies.driverViewControllerFactory,
            teamsViewControllerFactory: dependencies.teamsViewControllerFactory
        )
    }
    
    func makeStandingViewModel() -> StandingViewModel {
        return StandingViewModel(
            getDriversUseCase: makeGetDriversUseCase(),
            getTeamsUseCase: makeGetTeamsUseCase(),
            getDriverDetailsUseCase: makeGetDriverDetailsUseCase(),
            getTeamDetailsUseCase: makeGetTeamDetailsUseCase()
        )
    }
}
