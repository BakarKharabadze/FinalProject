//
//  RaceLastResultsResponse+DomainMapping.swift
//  
//
//  Created by Bakar Kharabadze on 7/16/24.
//

import Foundation
import Domain

extension RaceResultEntity {
    static func map(race: RaceLastResults.Race) -> RaceResultEntity? {
        guard race.results.count >= 3 else {
            return nil
        }
        
        let firstPlace = race.results[0].driver.familyName
        let secondPlace = race.results[1].driver.familyName
        let thirdPlace = race.results[2].driver.familyName
        
        return RaceResultEntity(
            round: race.round,
            grandPrixName: race.raceName,
            date: race.date,
            circuitId: race.circuit.circuitID,
            firstPlaceLastName: firstPlace,
            secondPlaceLastName: secondPlace,
            thirdPlaceLastName: thirdPlace
        )
    }
}

