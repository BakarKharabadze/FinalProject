//
//  ScheduleViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/10/24.
//

import Foundation
import Domain
import Common

// MARK: - ScheduleViewModelDelegate
public protocol ScheduleViewModelDelegate: AnyObject {
    func racesFetched(_ races: [RaceEntity])
    func raceResultFetched(_ raceResults: [RaceResultEntity])
}

//MARK: - ScheduleViewRoute
public enum ScheduleViewRoute {
    case showRaceDetail(with: RaceEntity)
}

//MARK: - ScheduleViewRouter
public protocol ScheduleViewRouter {
    func perform(to route: ScheduleViewRoute)
}

// MARK: - ScheduleViewModel
public final class ScheduleViewModel {
    
    // MARK: - Properties
    public var router: ScheduleViewRouter?
    private let getRacesUseCase: GetRacesUseCase
    private let getRaceResultUseCase: GetRaceResultUseCase
    public var upcomingRaces: [RaceEntity] = []
    public var pastRaces: [RaceEntity] = []
    public var raceResults: [RaceResultEntity] = []
    weak var delegate: ScheduleViewModelDelegate?
    
    // MARK: - Initialization
    public init(getRacesUseCase: GetRacesUseCase, getRaceResultUseCase: GetRaceResultUseCase) {
        self.getRacesUseCase = getRacesUseCase
        self.getRaceResultUseCase = getRaceResultUseCase
    }
    
    // MARK: - Methods
    func viewDidLoad() {
        fetchRaces()
        fetchRaceResult()
    }
    
    // MARK: - Private Methods
    private func fetchRaces() {
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
    
    private func fetchRaceResult() {
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
    
    func raceViewTapped(race: RaceEntity) {
        router?.perform(to: .showRaceDetail(with: race))
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
}
