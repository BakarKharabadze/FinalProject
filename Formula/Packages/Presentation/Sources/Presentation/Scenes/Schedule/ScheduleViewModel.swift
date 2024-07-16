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
}

public enum ScheduleViewRoute {
    case showRaceDetail(viewModel: RaceDetailViewModel)
}

public protocol ScheduleViewRouter {
    func perform(to route: ScheduleViewRoute)
}

public final class ScheduleViewModel {
    public var router: ScheduleViewRouter?
    private let getRacesUseCase: GetRacesUseCase
    public var upcomingRaces: [RaceEntity] = []
    public var pastRaces: [RaceEntity] = []
    weak var delegate: ScheduleViewModelDelegate?
    
    public init(getRacesUseCase: GetRacesUseCase) {
        self.getRacesUseCase = getRacesUseCase
    }
    
    public func viewDidLoad() {
        fetchRaces()
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
        let raceDetailViewModel = RaceDetailViewModel(race: race)
        router?.perform(to: .showRaceDetail(viewModel: raceDetailViewModel))
    }
}

