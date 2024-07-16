//
//  RaceDetailsSceneDIContainer.swift
//  Formula
//
//  Created by Bakar Kharabadze on 7/14/24.
//

import UIKit
import Domain
import Presentation
import Network
import Data

final class RaceDetailsSceneDIContainer {
    
    //MARK: - Dependencies
    struct Dependencies {
        let formulaApiDataTrnsferService: DataTransfer
    }
    
    //MARK: - Properties
    private let dependencies: Dependencies
    
    //MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

//MARK: - Use Cases
extension RaceDetailsSceneDIContainer {
    
}

//MARK: - Repository
extension RaceDetailsSceneDIContainer {
    
}


//MARK: - RaceDetailsViewController Factory
extension RaceDetailsSceneDIContainer: RaceDetailViewControllerFactory {
    func makeRaceDetailViewController(with viewModel: RaceDetailViewModel) -> RaceDetailViewController {
        RaceDetailViewController.create(with: viewModel)
    }
    
}

