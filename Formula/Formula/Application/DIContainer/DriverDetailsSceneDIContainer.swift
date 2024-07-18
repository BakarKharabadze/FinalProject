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
    
}

//MARK: - Repository
extension DriverDetailsSceneDIContainer {
    
}


//MARK: - DriverDetailsViewConroller Factory
extension DriverDetailsSceneDIContainer  {
//    func makeRaceDetailViewController(with viewModel: RaceDetailViewModel) -> RaceDetailViewController {
//        RaceDetailViewController.create(with: viewModel)
//    }
    
}
