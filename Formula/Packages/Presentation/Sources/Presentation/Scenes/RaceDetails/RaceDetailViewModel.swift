//
//  RaceDetailViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/14/24.
//

import Foundation
import Domain

public final class RaceDetailViewModel {
    public let race: RaceEntity
    
    public init(race: RaceEntity) {
        self.race = race
    }
}
