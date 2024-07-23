//
//  TeamDetailsResponse+DomainMapping.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation
import Domain

extension TeamDetailsEntity {
    static func map(teamDetailsResponse: TeamDetailsResponse) -> [TeamDetailsEntity] {
        return teamDetailsResponse.response.map { team in
            TeamDetailsEntity(
                name: team.name,
                worldTitle: "\(team.worldChampionships)",
                raceWins: "\(team.highestRaceFinish.number)",
                polePositions: "\(team.polePositions)",
                fastesLaps: "\(team.fastestLaps)",
                base: team.base,
                president: team.president,
                director: team.director,
                technicalManeger: team.technicalManager, 
                logo: team.logo
            )
        }
    }
}
