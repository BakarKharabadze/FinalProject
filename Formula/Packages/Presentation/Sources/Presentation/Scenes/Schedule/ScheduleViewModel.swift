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
    case showRaceDetail
}

public protocol ScheduleViewRouter {
    func perform(to: ScheduleViewRoute)
}

public final class ScheduleViewModel {
    public var router: ScheduleViewRouter?
    private let getRacesUseCase: GetRacesUseCase
    public var races: [RaceEntity] = []
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
                self?.races = races
                DispatchQueue.main.async {
                    self?.delegate?.racesFetched(races)
                }
            case .failure(let error):
                print("Failed to fetch races: \(error.localizedDescription)")
            }
        }
    }
}
    
    
