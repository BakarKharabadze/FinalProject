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
    
    func makeScheduleSceneDIContainer() -> ScheduleSceneDIContainer {
        let dependencies = ScheduleSceneDIContainer.Dependencies(formulaApiDataTransferService: formulaApiDataTransferService)
        return ScheduleSceneDIContainer(dependencies: dependencies)
    }
    
    func makeStandingSceneDIContainer() -> StandingSceneDIContainer {
           let dependencies = StandingSceneDIContainer.Dependencies(
               formulaApiDataTransferService: formulaApiDataTransferService,
               driverViewControllerFactory: makeDriversSceneDIContainer(), teamsViewControllerFactory: makeTeamsSceneDIContainer()
           )
           return StandingSceneDIContainer(dependencies: dependencies)
       }
    
    func makeDriversSceneDIContainer() -> DriversSceneDIContainer {
         let dependencies = DriversSceneDIContainer.Dependencies(
             formulaApiDataTransferService: formulaApiDataTransferService
         )
         return DriversSceneDIContainer(dependencies: dependencies)
     }
    
    func makeTeamsSceneDIContainer() -> TeamsSceneDIContainer {
        let dependencies = TeamsSceneDIContainer.Dependencies(formulaApiDataTransferService: formulaApiDataTransferService)
        return TeamsSceneDIContainer(dependencies: dependencies)
    }
    
    func makeHighlightSceneDIContainer() -> HighlighsSceneDIContainer {
        let dependencies = HighlighsSceneDIContainer.Dependencies(googleApiDataTransferService: googleApiDataTransferService)
        return HighlighsSceneDIContainer(dependencies: dependencies)
    }
    
 }

