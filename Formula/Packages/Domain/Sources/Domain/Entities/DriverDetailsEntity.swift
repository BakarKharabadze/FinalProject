//
//  DriverDetailsEntity.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation

public struct DriverDetailsEntity: Equatable {
    public let name: String
    public let driverNumber: String
    public let teamName: String
    public let races: String
    public let worldTitle: String
    public let raceWins: String
    public let podiums: String
    public let nationality: String
    public let birthday: String
    public let birthPlace: String
    
    public init(name: String, driverNumber: String, teamName: String, races: String, worldTitle: String, raceWins: String, podiums: String, nationality: String, birthday: String, birthPlace: String) {
        self.name = name
        self.driverNumber = driverNumber
        self.teamName = teamName
        self.races = races
        self.worldTitle = worldTitle
        self.raceWins = raceWins
        self.podiums = podiums
        self.nationality = nationality
        self.birthday = birthday
        self.birthPlace = birthPlace
    }
}
