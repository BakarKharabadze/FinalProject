//
//  AppDIContainer.swift
//  Formula
//
//  Created by Bakar Kharabadze on 7/9/24.
//

import UIKit
import Network
import Common
import Presentation

class AppDIContainer {
    
    lazy var appConfigurations = AppConfigurations()
    
    // MARK: - Network
    lazy var newsApiDataTransferService: DataTransfer = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfigurations.newsApiBaseURL)!,
                                          queryParameters: ["api_key": appConfigurations.newsApiKey])
        let apiDataNetwork = DefaultNetworkService(session: URLSession.shared,
                                                   config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
    
    lazy var formulaApiDataTransferService: DataTransfer = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfigurations.formulaApiBaseURL)!)
                                          
        let apiDataNetwork = DefaultNetworkService(session: URLSession.shared,
                                                   config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
    
    lazy var googleApiDataTransferService: DataTransfer = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfigurations.googleApiBaseURL)!,
                                          queryParameters: ["api_key": appConfigurations.googleApiKey])
        let apiDataNetwork = DefaultNetworkService(session: URLSession.shared,
                                                   config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
    
    func makeHomeSceneDIContainer() -> HomeSceneDIContainer {
        let dependencies = HomeSceneDIContainer.Dependencies(formulaApiDataTransferService: formulaApiDataTransferService, newsApiDataTransferService: newsApiDataTransferService, newsViewControllerFactory: makeNewsDetailSceneDIContainer())
        return HomeSceneDIContainer(dependencies: dependencies)
    }
    
    func makeNewsDetailSceneDIContainer() -> NewsSceneDIContainer {
        let dependencies = NewsSceneDIContainer.Dependencies(newsApiDataTransferService: newsApiDataTransferService)
        return NewsSceneDIContainer(dependencies: dependencies)
    }
    
}

