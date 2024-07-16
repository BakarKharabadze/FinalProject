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

final class NewsDetailsSceneDIContainer {
    
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
extension NewsDetailsSceneDIContainer {
    
}

//MARK: - Repository
extension NewsDetailsSceneDIContainer {
    
}


//MARK: - NewsViewController Factory
extension NewsDetailsSceneDIContainer: NewsDetailViewControllerFactory {
    func makeNewsDetailViewController(with viewModel: NewsDetailViewModel) -> NewsDetailViewController {
        NewsDetailViewController.create(with: viewModel)
    }
}
