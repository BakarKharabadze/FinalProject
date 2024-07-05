//
//  DriverEntity.swift
//
//
//  Created by Bakar Kharabadze on 7/4/24.
//

import Foundation

public struct DriverEntity: Identifiable {
    public let id = UUID()
    public let name: String
    public let imageName: String
    
    public init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
