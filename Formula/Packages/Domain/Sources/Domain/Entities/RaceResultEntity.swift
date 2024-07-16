//
//  RaceResultEntity.swift
//  
//
//  Created by Bakar Kharabadze on 7/16/24.
//

import Foundation

public struct RaceResultEntity: Identifiable {
    public var id: String { round }
    public let round: String
    public let grandPrixName: String
    public let date: String
    public let circuitId: String
    public let firstPlaceLastName: String
    public let secondPlaceLastName: String
    public let thirdPlaceLastName: String
    
    public init(round: String, grandPrixName: String, date: String, circuitId: String, firstPlaceLastName: String, secondPlaceLastName: String, thirdPlaceLastName: String) {
        self.round = round
        self.grandPrixName = grandPrixName
        self.date = date
        self.circuitId = circuitId
        self.firstPlaceLastName = firstPlaceLastName
        self.secondPlaceLastName = secondPlaceLastName
        self.thirdPlaceLastName = thirdPlaceLastName
    }
}

