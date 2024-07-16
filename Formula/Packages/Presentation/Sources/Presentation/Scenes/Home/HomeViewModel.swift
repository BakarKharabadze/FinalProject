//
//  HomeViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/9/24.
//

import Foundation
import Domain
import Common

public protocol HomeViewModelDelegate: AnyObject {
    func newsFetched(_ news: [NewsEntity])
    func driversFetched(_ drivers: [DriverEntity])
    func raceFetched(_ race: RaceEntity)
}

public enum HomeViewRoute {
    case showNewsDetail
}

public protocol HomeViewRouter {
    func perform(to: HomeViewRoute)
}

public final class HomeViewModel {
    public var router: HomeViewRouter?
    weak var delegate: HomeViewModelDelegate?
    
    private let getNewsUseCase: GetNewsUseCase
    private let getDriversUseCase: GetDriversUseCase
    private let getUpcomingRacesUseCase: GetRacesUseCase
    
    public var drivers: [DriverEntity] = []
    public var news: [NewsEntity] = []
    public var selectedNews: NewsEntity?
    public var upcomingRace: RaceEntity? 
    
    public init(getNewsUseCase: GetNewsUseCase, getDriversUseCase: GetDriversUseCase, getUpcomingRacesUseCase: GetRacesUseCase) {
        self.getNewsUseCase = getNewsUseCase
        self.getDriversUseCase = getDriversUseCase
        self.getUpcomingRacesUseCase = getUpcomingRacesUseCase
    }
    
    public func viewDidLoad() {
        fetchNews(query: "f1", from: "current", sortBy: "publishedAt", language: "en", apiKey: "57a97376638a49eeb91a6fd7dad7f1be")
        fetchDrivers()
        fetchUpcomingRace()
    }
    
    private func fetchNews(query: String, from: String, sortBy: String, language: String, apiKey: String) {
        getNewsUseCase.execute(query: query, from: from, sortBy: sortBy, language: language, apiKey: apiKey) { [weak self] result in
            switch result {
            case .success(let news):
                self?.news = news
                DispatchQueue.main.async {
                    self?.delegate?.newsFetched(news)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchDrivers() {
        getDriversUseCase.execute { [weak self] result in
            switch result {
            case .success(let drivers):
                DispatchQueue.main.async {
                    self?.drivers = drivers
                    self?.delegate?.driversFetched(drivers)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchUpcomingRace() {
        getUpcomingRacesUseCase.execute { [weak self] result in
            switch result {
            case .success(let races):
                if let nextRace = races.first(where: { race in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    guard let raceDate = dateFormatter.date(from: race.date) else { return false }
                    return raceDate >= Date()
                }) {
                    self?.upcomingRace = nextRace
                    DispatchQueue.main.async {
                        self?.delegate?.raceFetched(nextRace)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func newsViewTapped(news: NewsEntity) {
        selectedNews = news
        router?.perform(to: .showNewsDetail)
    }
}
