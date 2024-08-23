//
//  DriverDetailsViewControllerFactory.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import UIKit
import Domain

public protocol DriverDetailsViewControllerFactory {
    func makeDriverDetailsViewController(for drivers: DriverEntity) -> DriverDetailsViewController
}
