//
//  TeamDetailsSceneDIContainer.swift
//  Formula
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import UIKit
import Domain
import Presentation
import Network
import Data

final class TeamDetailsSceneDIContainer {
    
    //MARK: - Dependencies
    struct Dependencies {
        let detailsApiDataTransferService: DataTransfer
    }
    
    //MARK: - Properties
    private let dependencies: Dependencies
    
    //MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

//MARK: - Use Cases
extension TeamDetailsSceneDIContainer {
    func makeGetTeamDetailsUseCase() -> GetTeamDetailsUseCase {
        DefaultGetTeamDetailsUseCase(repository: makeTeamDetailsRepository())
    }
}

//MARK: - Repository
extension TeamDetailsSceneDIContainer {
    func  makeTeamDetailsRepository() -> TeamDetailsRepository {
        DefaultTeamDetailsRepository(dataTransferService: dependencies.detailsApiDataTransferService)
    }
}


//MARK: - TeamDetailsViewController Factory
extension TeamDetailsSceneDIContainer  {
//    func makeDriverDetailsViewController(with viewModel: DriverDetailsViewModel) -> DriverDetailsViewController {
//        DriverDetailsViewController.create(with: viewModel)
//    }
//    
//    func makeDriverDetailsViewModel(with driverEntity: DriverEntity) -> DriverDetailsViewModel {
//        DriverDetailsViewModel(driver: driverEntity, getDriverDetailsUseCase: makeGetDriverDetailsUseCase())
//    }
    
    func makeTeamDetailsViewController(with viewModel: TeamDetailsViewModel) -> TeamDetailsViewController {
        TeamDetailsViewController.create(with: viewModel)
    }
    
    func makeTeamDetailsViewModel(with teamEntity: TeamsEntity) -> TeamDetailsViewModel {
        TeamDetailsViewModel(getTeamDetailsUseCase: makeGetTeamDetailsUseCase(), team: teamEntity)
    }
}

