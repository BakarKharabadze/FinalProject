//
//  NewsSceneDIContainer.swift
//  Formula
//
//  Created by Bakar Kharabadze on 7/9/24.
//

import UIKit
import Domain
import Presentation
import Network
import Data

final class NewsSceneDIContainer {
    
    //MARK: - Dependencies
    struct Dependencies {
        let newsApiDataTransferService: DataTransfer
    }
    
    //MARK: - Properties
    private let dependencies: Dependencies
    
    //MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

//MARK: - Use Cases
extension NewsSceneDIContainer {
    
}

//MARK: - Repository
extension NewsSceneDIContainer {
    
}


//MARK: - HomeViewController Factory
extension NewsSceneDIContainer: NewsDetailViewControllerFactory {
    func makeNewsDetailViewController() -> UIViewController {
        NewsDetailViewController.create(with: makeNewsDetailViewModel())
    }
    
    func makeNewsDetailViewModel() -> NewsDetailViewModel {
        NewsDetailViewModel()
    }
}
