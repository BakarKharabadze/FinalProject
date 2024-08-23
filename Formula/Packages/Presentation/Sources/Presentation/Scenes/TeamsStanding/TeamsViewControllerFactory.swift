//
//  TeamsViewControllerFactory.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import UIKit
import Domain

public protocol TeamsViewControllerFactory {
    func makeTeamsViewController(for teams: TeamsEntity) -> TeamsViewController
}
