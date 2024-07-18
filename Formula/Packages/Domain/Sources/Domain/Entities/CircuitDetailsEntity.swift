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
    public let turns: String
    public let topSpeed: String
    public let practiceOneDate: String
    public let practiceOneTime: String
    public let practiceTwoDate: String
    public let practiceTwoTime: String
    public let practiceThreeDate: String
    public let practiceThreeTime: String
    public let qualificationDate: String
    public let qualificationTime: String
    public let raceDate: String
    public let raceTime: String
    
    public init(countryName: String, grandPrixName: String, date: String, circuitLenght: String, laps: String, turns: String, topSpeed: String, practiceOneDate: String, practiceOneTime: String, practiceTwoDate: String, practiceTwoTime: String, practiceThreeDate: String, practiceThreeTime: String, qualificationDate: String, qualificationTime: String, raceDate: String, raceTime: String) {
        self.countryName = countryName
        self.grandPrixName = grandPrixName
        self.date = date
        self.circuitLenght = circuitLenght
        self.laps = laps
        self.turns = turns
        self.topSpeed = topSpeed
        self.practiceOneDate = practiceOneDate
        self.practiceOneTime = practiceOneTime
        self.practiceTwoDate = practiceTwoDate
        self.practiceTwoTime = practiceTwoTime
        self.practiceThreeDate = practiceThreeDate
        self.practiceThreeTime = practiceThreeTime
        self.qualificationDate = qualificationDate
        self.qualificationTime = qualificationTime
        self.raceDate = raceDate
        self.raceTime = raceTime
    }
}
