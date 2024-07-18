//
//  DriverDetailsViewControllerFactory.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import UIKit

public protocol DriverDetailsViewControllerFactory {
    func makeDriverDetailsViewController(with viewModel: DriverDetailsViewModel) -> DriverDetailsViewController
}
