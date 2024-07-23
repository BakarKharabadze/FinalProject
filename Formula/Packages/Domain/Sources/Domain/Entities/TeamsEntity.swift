//
//  TeamsEntity.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation

public struct TeamsEntity: Equatable {
    public let position: String
    public let constructorName: String
    public let points: String
    public let nationality: String
    public let liveryImage: String
    public let constructorID: String
    
    public init(position: String, constructorName: String, points: String, nationality: String, liveryImage: String, constructorID: String) {
        self.position = position
        self.constructorName = constructorName
        self.points = points
        self.nationality = nationality
        self.liveryImage = liveryImage
        self.constructorID = constructorID
    }
}
