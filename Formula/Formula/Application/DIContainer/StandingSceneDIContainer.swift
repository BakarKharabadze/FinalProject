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
}

//MARK: - Repository
extension StandingSceneDIContainer {
    func makeDriverRepository() -> DriversRepository {
        DefaultDriversRepository(dataTransferService: dependencies.formulaApiDataTransferService)
    }
    
    func makeTeamsRepository() -> TeamsRepository {
        DefaultTeamsRepository(dataTransferService: dependencies.formulaApiDataTransferService)
    }
}

//MARK: - StandingSceneDIContainer Factory
extension StandingSceneDIContainer: StandingViewControllerFactory  {
    func makeStandingViewController() -> UIViewController {
        return StandingViewController.create(with: makeStandingViewModel(), driversViewControllerFactory: dependencies.driverViewControllerFactory, teamsViewControllerFactory: dependencies.teamsViewControllerFactory)
    }
    
    func makeStandingViewModel() -> StandingViewModel {
        return StandingViewModel(getDriversUseCase: makeGetDriversUseCase(), getTeamsUseCase: makeGetTeamsUseCase())
    }
}
