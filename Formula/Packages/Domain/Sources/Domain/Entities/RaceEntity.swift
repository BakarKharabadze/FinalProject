//
//  RaceEntity.swift
//
//
//  Created by Bakar Kharabadze on 7/10/24.
//

import Foundation

public struct RaceEntity: Equatable {
    public let round: String
    public let grandPrixName: String
    public let circuitName: String
    public let date: String
    public let time: String
    public var image: String
    public let startsIn: String
    public let countryFlag: String
    public let circuitID: String
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

    public init(round: String, grandPrixName: String, circuitName: String, date: String, time: String, image: String, startsIn: String, countryFlag: String, circuitID: String, turns: String, topSpeed: String, practiceOneDate: String, practiceOneTime: String, practiceTwoDate: String, practiceTwoTime: String, practiceThreeDate: String, practiceThreeTime: String, qualificationDate: String, qualificationTime: String) {
        self.round = round
        self.grandPrixName = grandPrixName
        self.circuitName = circuitName
        self.date = date
        self.time = time
        self.image = image
        self.startsIn = startsIn
        self.countryFlag = countryFlag
        self.circuitID = circuitID
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
    }
}
