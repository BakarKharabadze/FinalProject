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
extension DriversSceneDIContainer {
    func makeGetDriversUseCase() -> GetDriversUseCase {
        DefaultGetDriversUseCase(repository: makeDriverRepository())
    }
    
    func makeGetDriverDetailUseCase() -> GetDriverDetailsUseCase {
        DefaultGetDriversDetailsUseCase(repository: makeDriverDetailsRepository())
    }
}

//MARK: - Repository
extension DriversSceneDIContainer {
    func makeDriverRepository() -> DriversRepository {
        DefaultDriversRepository(dataTransferService: dependencies.formulaApiDataTransferService)
    }
    
    func makeDriverDetailsRepository() -> DriverDetailsRepository {
        DefaultDriverDetailsRepository(dataTransferService: dependencies.formulaSportApiDataTransferService)
    }
}

//MARK: - DriverSceneDIContainer Factory
extension DriversSceneDIContainer: DriversViewControllerFactory  {
    
    func makeDriversViewController(with viewModel: DriversViewModel) -> DriversViewController {
        DriversViewController.create(with: viewModel)
    }
    
    func makeDriversDetailViewModel() -> DriversViewModel {
        DriversViewModel(getDriverDetailsUseCase: makeGetDriverDetailUseCase(), drivers: [])
    }
}
