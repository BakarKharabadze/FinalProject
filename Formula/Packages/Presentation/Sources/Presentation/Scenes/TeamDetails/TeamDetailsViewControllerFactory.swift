//
//  TeamDetailsViewControllerFactory.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import UIKit
import Domain

public protocol TeamDetailsViewControllerFactory {
    func makeTeamDetailsViewController(for teams: TeamsEntity) -> TeamDetailsViewController
}
