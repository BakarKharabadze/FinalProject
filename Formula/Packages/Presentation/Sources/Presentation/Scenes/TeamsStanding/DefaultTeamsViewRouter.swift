//
//  DefaultTeamsViewRouter.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//
import UIKit

class DefaultTeamsViewRouter: StandingViewRouter {
    
    private weak var viewController: TeamsViewController?
    private let teamsViewControllerFactory: TeamsViewControllerFactory
    
    init(view: TeamsViewController, teamsViewControllerFactory: TeamsViewControllerFactory) {
        self.viewController = view
        self.teamsViewControllerFactory = teamsViewControllerFactory
    }
    
    func perform(to: StandingViewRoute) {
    }
}
