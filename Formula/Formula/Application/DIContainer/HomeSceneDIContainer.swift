//
//  HomeSceneDIContainer.swift
//  Formula
//
//  Created by Bakar Kharabadze on 7/9/24.
//

import UIKit
import Domain
import Presentation
import Network
import Data

final class HomeSceneDIContainer {
    
    //MARK: - Dependencies
    struct Dependencies {
        let formulaApiDataTransferService: DataTransfer
        let newsApiDataTransferService: DataTransfer
        let newsViewControllerFactory: NewsDetailViewControllerFactory
    }
    
    //MARK: - Properties
    private let dependencies: Dependencies
    
    //MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

//MARK: - Use Cases
extension HomeSceneDIContainer {
    func makeGetNewsUseCase() -> GetNewsUseCase {
        DefaultGetNewsUseCase(repository: makeNewsRepository())
    }
    
    func makeGetDriversUseCase() -> GetDriversUseCase {
        DefaultGetDriversUseCase(repository: makeDriversRepository())
    }
    
    func makeGetRaceUseCase() -> GetRacesUseCase {
        DefaultGetRacesUseCase(repository: makeRaceRepository())
    }
}

//MARK: - Repository
extension HomeSceneDIContainer {
    func makeNewsRepository() -> NewsRepository {
        DefaultNewsRepository(dataTransferService: dependencies.newsApiDataTransferService)
    }
    
    func makeDriversRepository() -> DriversRepository {
        DefaultDriversRepository(dataTransferService: dependencies.formulaApiDataTransferService)
    }
    
    func makeRaceRepository() -> RaceRepository {
        DefaultRacesRepository(dataTransferService: dependencies.formulaApiDataTransferService)
    }
}


//MARK: - HomeViewController Factory
extension HomeSceneDIContainer: HomeViewControllerFactory {
    func makeHomeViewController() -> UIViewController {
        HomeViewController.create(with: makeHomeViewModel(), newsViewControllersFactory: dependencies.newsViewControllerFactory)
    }
    
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(getNewsUseCase: makeGetNewsUseCase(), getDriversUseCase: makeGetDriversUseCase(), getUpcomingRacesUseCase: makeGetRaceUseCase())
    }
}
