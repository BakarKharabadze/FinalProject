//
//  ScheduleViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/10/24.
//

import Foundation
import Domain
import Common

public protocol ScheduleViewModelDelegate: AnyObject {
    func racesFetched(_ races: [RaceEntity])
    func raceResultFetched(_ raceResults: [RaceResultEntity])
}

public enum ScheduleViewRoute {
    case showRaceDetail(with: RaceEntity)
}

public protocol ScheduleViewRouter {
    func perform(to route: ScheduleViewRoute)
}

public final class ScheduleViewModel {
    public var router: ScheduleViewRouter?
    private let getRacesUseCase: GetRacesUseCase
    private let getRaceResultUseCase: GetRaceResultUseCase
    public var upcomingRaces: [RaceEntity] = []
    public var pastRaces: [RaceEntity] = []
    public var raceResults: [RaceResultEntity] = []
    weak var delegate: ScheduleViewModelDelegate?
    
    public init(getRacesUseCase: GetRacesUseCase, getRaceResultUseCase: GetRaceResultUseCase) {
        self.getRacesUseCase = getRacesUseCase
        self.getRaceResultUseCase = getRaceResultUseCase
    }
    
    public func viewDidLoad() {
        fetchRaces()
        fetchRaceResult()
    }
    
    public func fetchRaces() {
        getRacesUseCase.execute { [weak self] result in
            switch result {
            case .success(let races):
                self?.filterRaces(races: races)
                DispatchQueue.main.async {
                    self?.delegate?.racesFetched(races)
                }
            case .failure(let error):
                print("Failed to fetch races: \(error.localizedDescription)")
            }
        }
    }
    
    public func fetchRaceResult() {
        getRaceResultUseCase.execute { [weak self] result in
            switch result {
            case .success(let raceResults):
                self?.raceResults = raceResults
                DispatchQueue.main.async {
                    self?.delegate?.raceResultFetched(raceResults)
                }
            case .failure(let error):
                print("Failed to fetch race results: \(error.localizedDescription)")
            }
        }
    }
    
    private func filterRaces(races: [RaceEntity]) {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.upcomingRaces = races.filter { race in
            if let raceDate = dateFormatter.date(from: race.date) {
                return raceDate >= currentDate
            }
            return false
        }
        
        self.pastRaces = races.filter { race in
            if let raceDate = dateFormatter.date(from: race.date) {
                return raceDate < currentDate
            }
            return false
        }
    }
    
    func raceViewTapped(race: RaceEntity) {
        router?.perform(to: .showRaceDetail(with: race))
    }
}
