//
//  File.swift
//  
//
//  Created by Bakar Kharabadze on 7/10/24.
//

import Foundation
import Domain

extension RaceEntity {
    static func map(raceResponse: [F1Season.Race]) -> [RaceEntity] {
        return raceResponse.map { race in
            RaceEntity(
                round: race.round,
                grandPrixName: race.raceName,
                date: race.date ?? "",
                image: race.circuit?.url ?? "",
                startsIn: race.time ?? "",
                countryFlag: race.circuit?.location.country ?? "",
                circuitID: race.round
            )
        }
    }
}
