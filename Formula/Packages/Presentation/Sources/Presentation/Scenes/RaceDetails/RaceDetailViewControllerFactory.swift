//
//  RaceDetailViewControllerFactory.swift
//
//
//  Created by Bakar Kharabadze on 7/14/24.
//

import Foundation

public protocol RaceDetailViewControllerFactory {
    func makeRaceDetailViewController(with viewModel: RaceDetailViewModel) -> RaceDetailViewController
}
