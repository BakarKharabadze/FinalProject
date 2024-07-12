//
//  HighlighsSceneDIContainer.swift
//  Formula
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import UIKit
import Domain
import Presentation
import Network
import Data

final class HighlighsSceneDIContainer {
    
    //MARK: - Dependencies
    struct Dependencies {
        let googleApiDataTransferService: DataTransfer
    }
    
    //MARK: - Properties
    private let dependencies: Dependencies
    
    //MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

//MARK: - Use Cases
extension HighlighsSceneDIContainer {
    func makeGetVideosUseCase() -> GetVideosUseCase {
        DefaultGetVideosUseCase(repository: makeVideosRepository())
    }
  
}

//MARK: - Repository
extension HighlighsSceneDIContainer {
    func makeVideosRepository() -> VideosRepository {
        DefaultVideosRepository(dataTransferService: dependencies.googleApiDataTransferService)
    }
   
}


//MARK: - HighlightViewController Factory
extension HighlighsSceneDIContainer: HighlightViewControllerFactory  {
    func makeHighlightViewController() -> HighlightsViewController {
        HighlightsViewController.create(with: makeVideosViewModel())
    }
    
    func makeVideosViewModel() -> HighlightsViewModel {
        HighlightsViewModel(getVideosUseCase: makeGetVideosUseCase())
    }
}
