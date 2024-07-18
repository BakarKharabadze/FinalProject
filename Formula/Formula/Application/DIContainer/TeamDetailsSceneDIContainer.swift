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
    
}

//MARK: - Repository
extension TeamDetailsSceneDIContainer {
    
}


//MARK: - TeamDetailsViewController Factory
extension TeamDetailsSceneDIContainer  {
//    func makeRaceDetailViewController(with viewModel: RaceDetailViewModel) -> RaceDetailViewController {
//        RaceDetailViewController.create(with: viewModel)
//    }
    
}

