//
//  ScheduleSceneDIContainer.swift
//  Formula
//
//  Created by Bakar Kharabadze on 7/10/24.
//

import UIKit
import Domain
import Presentation
import Network
import Data

final class ScheduleSceneDIContainer {
    
    //MARK: - Dependencies
    struct Dependencies {
        let formulaApiDataTransferService: DataTransfer
        let raceDetailViewControllerFactory: RaceDetailViewControllerFactory
    }
    
    //MARK: - Properties
    private let dependencies: Dependencies
    
    //MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

//MARK: - Use Cases
extension ScheduleSceneDIContainer {
    func makeGetRacesUseCase() -> GetRacesUseCase {
        DefaultGetRacesUseCase(repository: makeRaceRepository())
    }
    
    func makeGetRaceResultUseCase() -> GetRaceResultUseCase {
        DefaultGetRaceResultUseCase(repository: makeRaceResultRepository())
    }
}

//MARK: - Repository
extension ScheduleSceneDIContainer {
    func makeRaceRepository() -> RaceRepository {
        DefaultRacesRepository(dataTransferService: dependencies.formulaApiDataTransferService)
    }
    
    func makeRaceResultRepository() -> RaceResultRepository {
        DefaultRaceResultRepository(dataTransferService: dependencies.formulaApiDataTransferService)
    }

}


//MARK: - ScheduleSceneDIContainer Factory
extension ScheduleSceneDIContainer: ScheduleViewControllerFactory {
    func makeScheduleViewController() -> UIViewController {
        ScheduleViewController.create(with: makeScheduleViewModel(), raceDetailViewControllerFactory: dependencies.raceDetailViewControllerFactory)
    }

    func makeScheduleViewModel() -> ScheduleViewModel {
        ScheduleViewModel(getRacesUseCase: makeGetRacesUseCase(), getRaceResultUseCase: makeGetRaceResultUseCase())
    }
    
}
