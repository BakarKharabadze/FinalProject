//
//  TeamDetailsViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation
import Domain

public final class TeamDetailsViewModel {
    public let team: TeamsEntity
    
    public init(team: TeamsEntity) {
        self.team = team
    }
}

