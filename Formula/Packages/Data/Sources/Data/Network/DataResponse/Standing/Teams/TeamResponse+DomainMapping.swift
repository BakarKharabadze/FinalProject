//
//  TeamResponse+DomainMapping.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation
import Domain

extension TeamsEntity {
    static func map(teamResponse: [TeamsStandings.ConstructorStanding]) -> [TeamsEntity] {
        teamResponse.map { team in
            TeamsEntity(position: team.position,
                        constructorName: team.constructor.name,
                        points: team.points,
                        nationality: team.constructor.nationality,
                        liveryImage: team.constructor.name,
                        constructorID: team.constructor.constructorID)
        }
    }
}
