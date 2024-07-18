//
//  TeamDetailsEntity.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation

public struct TeamDetailsEntity: Equatable {
    public let name: String
    public let worldTitle: String
    public let raceWins: String
    public let polePositions: String
    public let fastesLaps: String
    public let base: String
    public let president: String
    public let director: String
    public let technicalManeger: String
    
    public init(name: String, worldTitle: String, raceWins: String, polePositions: String, fastesLaps: String, base: String, president: String, director: String, technicalManeger: String) {
        self.name = name
        self.worldTitle = worldTitle
        self.raceWins = raceWins
        self.polePositions = polePositions
        self.fastesLaps = fastesLaps
        self.base = base
        self.president = president
        self.director = director
        self.technicalManeger = technicalManeger
    }
}
