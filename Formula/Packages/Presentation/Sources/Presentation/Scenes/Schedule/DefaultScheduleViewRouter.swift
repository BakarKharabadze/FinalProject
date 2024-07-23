//
//  DefaultScheduleViewRouter.swift
//
//
//  Created by Bakar Kharabadze on 7/14/24.
//

import UIKit

final class DefaultScheduleViewRouter: ScheduleViewRouter {
    
    // MARK: - Properties
    weak var view: ScheduleViewController?
    private let raceDetailViewControllerFactory: RaceDetailViewControllerFactory
    
    // MARK: - Initialization
    init(view: ScheduleViewController, raceDetailViewControllerFactory: RaceDetailViewControllerFactory) {
        self.view = view
        self.raceDetailViewControllerFactory = raceDetailViewControllerFactory
    }
    
    // MARK: - Methods
    func perform(to route: ScheduleViewRoute) {
        switch route {
        case .showRaceDetail(let race):
            let vc = raceDetailViewControllerFactory.makeRaceDetailViewController(with: race)
            view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
