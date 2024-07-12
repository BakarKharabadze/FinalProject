//
//  DriversSceneDIContainer.swift
//  Formula
//
//  Created by Bakar Kharabadze on 7/11/24.
//

import UIKit
import Domain
import Presentation
import Network
import Data

final class DriversSceneDIContainer {
    
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
extension DriversSceneDIContainer {
    func makeGetDriversUseCase() -> GetDriversUseCase {
        DefaultGetDriversUseCase(repository: makeDriverRepository())
    }
}

//MARK: - Repository
extension DriversSceneDIContainer {
    func makeDriverRepository() -> DriversRepository {
        DefaultDriversRepository(dataTransferService: dependencies.formulaApiDataTransferService)
    }
}

//MARK: - DriverSceneDIContainer Factory
extension DriversSceneDIContainer: DriversViewControllerFactory  {
    
    func makeDriversViewController(with viewModel: DriversViewModel) -> DriversViewController {
        DriversViewController.create(with: viewModel)
    }
    
    func makeDriversViewController() -> UIViewController {
        DriversViewController.create(with: makeDriversDetailViewModel())
    }
    
    func makeDriversDetailViewModel() -> DriversViewModel {
        DriversViewModel(drivers: [])
    }
}
