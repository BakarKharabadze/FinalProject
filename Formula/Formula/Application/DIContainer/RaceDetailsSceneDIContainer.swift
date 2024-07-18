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
        let formulaSportsApiDataTrnsferService: DataTransfer
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
    func makeGetCiruitDetailsUseCase() -> GetCircuitDetailsUseCase {
        DefaultGetCircuitDetailsUseCase(repository: makeFormulaSportsRepository())
    }
}

//MARK: - Repository
extension RaceDetailsSceneDIContainer {
    func makeFormulaSportsRepository() -> FormulaSportsRepository {
        DefaultFormulaSportsRepository(dataTransferService: dependencies.formulaSportsApiDataTrnsferService)
    }
}


//MARK: - RaceDetailsViewController Factory
extension RaceDetailsSceneDIContainer: RaceDetailViewControllerFactory {
    func makeRaceDetailViewController(with race: RaceEntity) -> RaceDetailViewController {
        RaceDetailViewController.create(with: makeRaceDetailViewModel(with: race))
    }
    
    func makeRaceDetailViewModel(with raceEntity: RaceEntity) -> RaceDetailViewModel {
        RaceDetailViewModel(race: raceEntity, getCircuitDetailsUseCase: makeGetCiruitDetailsUseCase())
    }
}
