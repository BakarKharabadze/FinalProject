//
//  TeamsViewControllerFactory.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import UIKit

public protocol TeamsViewControllerFactory {
    func makeTeamsViewController(with viewModel: TeamsViewModel) -> TeamsViewController
}
