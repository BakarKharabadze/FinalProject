//
//  File.swift
//  
//
//  Created by Bakar Kharabadze on 7/11/24.
//

import UIKit

public protocol DriversViewControllerFactory {
    func makeDriversViewController(with viewModel: DriversViewModel) -> DriversViewController
}

