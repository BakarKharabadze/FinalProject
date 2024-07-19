//
//  CircuitDetailsResponse.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation

public struct CircuitDetailsResponse: Decodable {
    public let response: [CircuitDetail]

    public struct CircuitDetail: Codable {
        public let id: Int
        public let name: String
        public let image: String
        public let competition: Competition
        public let location: CircuitLocation
        public let firstGrandPrix: Int
        public let laps: Int
        public let length: String
        public let raceDistance: String
        public let lapRecord: LapRecord?
        public let capacity: Int?
        public let opened: Int?
    }

    public struct Competition: Codable {
        public let id: Int
        public let name: String
    }

    public struct CircuitLocation: Codable {
        public let country: String
        public let city: String
    }

    public struct LapRecord: Codable {
        public let time: String?
        public let driver: String?
        public let year: String?
    }

}
