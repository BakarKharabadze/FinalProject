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
}

//MARK: - Repository
extension TeamsSceneDIContainer {
    func makeTeamsRepository() -> TeamsRepository {
        DefaultTeamsRepository(dataTransferService: dependencies.formulaApiDataTransferService)
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
        TeamsViewModel(teams: [])
    }
}
