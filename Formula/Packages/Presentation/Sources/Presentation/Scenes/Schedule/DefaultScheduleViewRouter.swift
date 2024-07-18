//
//  DefaultScheduleViewRouter.swift
//
//
//  Created by Bakar Kharabadze on 7/14/24.
//

import UIKit

class DefaultScheduleViewRouter: ScheduleViewRouter {
    
    weak var view: ScheduleViewController?
    let raceDetailViewControllerFactory: RaceDetailViewControllerFactory
    
    init(view: ScheduleViewController,
         raceDetailViewControllerFactory: RaceDetailViewControllerFactory) {
        self.view = view
        self.raceDetailViewControllerFactory = raceDetailViewControllerFactory
    }
    
    func perform(to route: ScheduleViewRoute) {
        switch route {
        case .showRaceDetail(let race):
            let vc = raceDetailViewControllerFactory.makeRaceDetailViewController(with: race)
            view?.navigationController?.pushViewController(vc, animated: false)
        }
    }
}
