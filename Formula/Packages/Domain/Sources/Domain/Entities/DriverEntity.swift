//
//  DriverEntity.swift
//
//
//  Created by Bakar Kharabadze on 7/4/24.
//

import Foundation

public struct DriverEntity: Identifiable {
    public var id: String { driverId }
    public let driverId: String
    public let position: String
    public let givenName: String
    public let familyName: String
    public let constructorName: String
    public let points: String
    
    public init(driverId: String, position: String, givenName: String, familyName: String, constructorName: String, points: String) {
        self.driverId = driverId
        self.position = position
        self.givenName = givenName
        self.familyName = familyName
        self.constructorName = constructorName
        self.points = points
    }
}
