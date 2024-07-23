//
//  CircuitDetailsEntity.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation

public struct CircuitDetailsEntity: Equatable {
    public let countryName: String
    public let grandPrixName: String
    public let date: String
    public let circuitLenght: String
    public let laps: String
    public let raceDistance: String
    
    public init(countryName: String, grandPrixName: String, date: String, circuitLenght: String, laps: String, raceDistance: String) {
        self.countryName = countryName
        self.grandPrixName = grandPrixName
        self.date = date
        self.circuitLenght = circuitLenght
        self.laps = laps
        self.raceDistance = raceDistance
    }
}
