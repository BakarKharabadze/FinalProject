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
}

//MARK: - Repository
extension HomeSceneDIContainer {
    func makeNewsRepository() -> NewsRepository {
        DefaultNewsRepository(dataTransferService: dependencies.newsApiDataTransferService)
    }
}


//MARK: - HomeViewController Factory
extension HomeSceneDIContainer: HomeViewControllerFactory {
    func makeHomeViewController() -> UIViewController {
        HomeViewController.create(with: makeHomeViewModel(), newsViewControllersFactory: dependencies.newsViewControllerFactory)
    }
    
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(getNewsUseCase: makeGetNewsUseCase())
    }
}
