//
//  CircuitDetailsResponse+DomainMapping.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation
import Domain

extension CircuitDetailsEntity {
    static func map(circuitDetailsResponse: CircuitResponse) -> [CircuitDetailsEntity] {
        return circuitDetailsResponse.response.map { circuit in
            CircuitDetailsEntity(
                countryName: circuit.competition.location.country,
                grandPrixName: circuit.competition.name,
                date: "\(circuit.opened)",
                circuitLenght: circuit.length,
                laps: "\(circuit.laps)",
                raceDistance: circuit.raceDistance
            )
        }
    }
}
