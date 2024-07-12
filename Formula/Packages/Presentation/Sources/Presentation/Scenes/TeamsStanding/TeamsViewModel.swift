//
//  TeamsViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation
import Domain

public final class TeamsViewModel {
    
    var teams: [TeamsEntity]
    
    public init(teams: [TeamsEntity]) {
        self.teams = teams
    }
}
