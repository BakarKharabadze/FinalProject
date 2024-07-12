//
//  TeamsEntity.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation

public struct TeamsEntity {
    public let position: String
    public let constructorName: String
    public let points: String
    public let nationality: String
    
    public init(position: String, constructorName: String, points: String, nationality: String) {
        self.position = position
        self.constructorName = constructorName
        self.points = points
        self.nationality = nationality
    }
}
