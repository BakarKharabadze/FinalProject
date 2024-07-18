//
//  TeamDetailsViewControllerFactory.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import UIKit

public protocol TeamDetailsViewControllerFactory {
    func makeTeamDetailsViewController(with viewModel: TeamDetailsViewModel) -> TeamDetailsViewController
}
