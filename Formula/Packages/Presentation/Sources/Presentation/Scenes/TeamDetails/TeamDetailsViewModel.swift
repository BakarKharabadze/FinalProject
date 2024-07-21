//
//  TeamDetailsViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation
import Domain

public final class TeamDetailsViewModel {
    //MARK: - Properties
    public let team: TeamsEntity
    
    //MARK: - Init
    public init(team: TeamsEntity) {
        self.team = team
    }
}

