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
    
    lazy var formulaSportsApiDataTransferService: DataTransfer = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfigurations.formulaSportsApiBaseURL)!,
                                          headers: ["x-rapidapi-key": appConfigurations.formulaSportsApiKey])
        let apiDataNetwork = DefaultNetworkService(session: URLSession.shared,
                                                   config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
    
    func makeHomeSceneDIContainer() -> HomeSceneDIContainer {
        let dependencies = HomeSceneDIContainer.Dependencies(formulaApiDataTransferService: formulaApiDataTransferService, newsApiDataTransferService: newsApiDataTransferService, newsViewControllerFactory: makeNewsDetailSceneDIContainer())
        return HomeSceneDIContainer(dependencies: dependencies)
    }
    
    func makeNewsDetailSceneDIContainer() -> NewsDetailsSceneDIContainer {
        let dependencies = NewsDetailsSceneDIContainer.Dependencies(newsApiDataTransferService: newsApiDataTransferService)
        return NewsDetailsSceneDIContainer(dependencies: dependencies)
    }
    
    func makeScheduleSceneDIContainer() -> ScheduleSceneDIContainer {
        let dependencies = ScheduleSceneDIContainer.Dependencies(formulaApiDataTransferService: formulaApiDataTransferService, raceDetailViewControllerFactory: makeRaceDetailSceneDIContainer())
        return ScheduleSceneDIContainer(dependencies: dependencies)
    }
    
    func makeRaceDetailSceneDIContainer() -> RaceDetailsSceneDIContainer {
        let dependencies = RaceDetailsSceneDIContainer.Dependencies(formulaSportsApiDataTrnsferService: formulaSportsApiDataTransferService)
        return RaceDetailsSceneDIContainer(dependencies: dependencies)
    }
    
    func makeStandingSceneDIContainer() -> StandingSceneDIContainer {
           let dependencies = StandingSceneDIContainer.Dependencies(
               formulaApiDataTransferService: formulaApiDataTransferService,
               driverViewControllerFactory: makeDriversSceneDIContainer(), teamsViewControllerFactory: makeTeamsSceneDIContainer(), formulaSportApiDataTransferService: formulaSportsApiDataTransferService
           )
           return StandingSceneDIContainer(dependencies: dependencies)
       }
    
    func makeDriversSceneDIContainer() -> DriversSceneDIContainer {
         let dependencies = DriversSceneDIContainer.Dependencies(
            formulaApiDataTransferService: formulaApiDataTransferService, formulaSportApiDataTransferService: formulaSportsApiDataTransferService, driverDetailsVIewControllerFactory: makeDriverDetailsSceneDIContainer()
         )
         return DriversSceneDIContainer(dependencies: dependencies)
     }
    
    func makeTeamsSceneDIContainer() -> TeamsSceneDIContainer {
        let dependencies = TeamsSceneDIContainer.Dependencies(formulaApiDataTransferService: formulaApiDataTransferService, formulaSportApiDataTransferService: formulaSportsApiDataTransferService, teamDetailsViewControllerFactory: makeTeamDetailsScemeDIContainer())
        return TeamsSceneDIContainer(dependencies: dependencies)
    }
    
    func makeHighlightSceneDIContainer() -> HighlighsSceneDIContainer {
        let dependencies = HighlighsSceneDIContainer.Dependencies(googleApiDataTransferService: googleApiDataTransferService)
        return HighlighsSceneDIContainer(dependencies: dependencies)
    }
    
    func makeDriverDetailsSceneDIContainer() -> DriverDetailsSceneDIContainer {
        let dependencies = DriverDetailsSceneDIContainer.Dependencies(detailsApiDataTransferService: formulaSportsApiDataTransferService)
        return DriverDetailsSceneDIContainer(dependencies: dependencies)
    }
    
    func makeTeamDetailsScemeDIContainer() -> TeamDetailsSceneDIContainer {
        let dependencies = TeamDetailsSceneDIContainer.Dependencies(detailsApiDataTransferService: formulaSportsApiDataTransferService)
        return TeamDetailsSceneDIContainer(dependencies: dependencies)
    }
    
 }

