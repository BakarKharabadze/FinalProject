//
//  TeamsSceneDIContainer.swift
//  Formula
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import UIKit
import Domain
import Presentation
import Network
import Data

final class TeamsSceneDIContainer {
    
    //MARK: - Dependencies
    struct Dependencies {
        let formulaApiDataTransferService: DataTransfer
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
extension TeamsSceneDIContainer {
    func makeGetTeamsUseCase() -> GetTeamsUseCase {
        DefaultGetTeamsUseCase(repository: makeTeamsRepository())
    }
    
    func makeGetTeamDetailsUseCase() -> GetTeamDetailsUseCase {
        DefaultGetTeamDetailsUseCase(repository: makeTeamDetailsRepository())
    }
}

//MARK: - Repository
extension TeamsSceneDIContainer {
    func makeTeamsRepository() -> TeamsRepository {
        DefaultTeamsRepository(dataTransferService: dependencies.formulaApiDataTransferService)
    }
    
    func makeTeamDetailsRepository() -> TeamDetailsRepository {
        DefaultTeamDetailsRepository(dataTransferService: dependencies.formulaSportApiDataTransferService)
    }
}

//MARK: - TeamsSceneDIContainer Factory
extension TeamsSceneDIContainer: TeamsViewControllerFactory  {
    func makeTeamsViewController(with viewModel: TeamsViewModel) -> TeamsViewController {
        TeamsViewController.create(with: viewModel)
    }
    
    func makeTeamsViewController() -> UIViewController {
        TeamsViewController.create(with: makeTeamsDetailViewModel())
    }
    
    func makeTeamsDetailViewModel() -> TeamsViewModel {
        TeamsViewModel(getTeamDetailsUseCase: makeGetTeamDetailsUseCase(), getTeamsUseCase: makeGetTeamsUseCase())
    }
}
