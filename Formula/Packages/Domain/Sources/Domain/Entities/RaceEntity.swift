//
//  RaceEntity.swift
//
//
//  Created by Bakar Kharabadze on 7/10/24.
//

import Foundation

public struct RaceEntity {
    public let round: String
    public let grandPrixName: String
    public let date: String
    public var image: String
    public let startsIn: String
    public let countryFlag: String
    public let circuitID: String
    
    public init(round: String, grandPrixName: String, date: String, image: String, startsIn: String, countryFlag: String, circuitID: String) {
        self.round = round
        self.grandPrixName = grandPrixName
        self.date = date
        self.image = image
        self.startsIn = startsIn
        self.countryFlag = countryFlag
        self.circuitID = circuitID
    }
}
