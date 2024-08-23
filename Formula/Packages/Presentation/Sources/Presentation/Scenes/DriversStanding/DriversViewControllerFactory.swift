//
//  DriversViewControllerFactory.swift
//  
//
//  Created by Bakar Kharabadze on 7/11/24.
//

import UIKit
import Domain

public protocol DriversViewControllerFactory {
    func makeDriversViewController(for drivers: DriverEntity) -> DriversViewController
}

