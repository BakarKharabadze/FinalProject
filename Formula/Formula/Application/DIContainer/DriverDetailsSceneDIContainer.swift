//
//  DriverDetailsSceneDIContainer.swift
//  Formula
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import UIKit
import Domain
import Presentation
import Network
import Data

final class DriverDetailsSceneDIContainer {
    
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
extension DriverDetailsSceneDIContainer {
    func makeGetDriverDetailsUseCase() -> GetDriverDetailsUseCase {
        DefaultGetDriversDetailsUseCase(repository: makeDriverDetailsRepository())
    }
}

//MARK: - Repository
extension DriverDetailsSceneDIContainer {
    func makeDriverDetailsRepository() -> DriverDetailsRepository {
        DefaultDriverDetailsRepository(dataTransferService: dependencies.detailsApiDataTransferService)
    }
}


//MARK: - DriverDetailsViewConroller Factory
extension DriverDetailsSceneDIContainer  {
    
    func makeDriverDetailsViewController(with viewModel: DriverDetailsViewModel) -> DriverDetailsViewController {
        DriverDetailsViewController.create(with: viewModel)
    }
    
    func makeDriverDetailsViewModel(with driverEntity: DriverEntity) -> DriverDetailsViewModel {
        DriverDetailsViewModel(driver: driverEntity, getDriverDetailsUseCase: makeGetDriverDetailsUseCase())
    }
}
