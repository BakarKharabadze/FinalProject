//
//  RaceDetailViewControllerFactory.swift
//
//
//  Created by Bakar Kharabadze on 7/14/24.
//

import Domain

public protocol RaceDetailViewControllerFactory {
    func makeRaceDetailViewController(with race: RaceEntity) -> RaceDetailViewController
}
