//
//  CircuitDetailsResponse.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation

// MARK: - CircuitResponse
struct CircuitResponse: Decodable {
    let get: String
    let parameters: Parameters
    let errors: [String]
    let results: Int
    let response: [Circuit]
    
    // MARK: - Parameters
    struct Parameters: Decodable {
        let search: String
    }
    
    // MARK: - Circuit
    struct Circuit: Decodable {
        let id: Int
        let name: String
        let image: String
        let competition: Competition
        let firstGrandPrix: Int
        let laps: Int
        let length: String
        let raceDistance: String
        let lapRecord: LapRecord
        let capacity: Int
        let opened: Int
        let owner: String?
        
        enum CodingKeys: String, CodingKey {
            case id, name, image, competition
            case firstGrandPrix = "first_grand_prix"
            case laps, length
            case raceDistance = "race_distance"
            case lapRecord = "lap_record"
            case capacity, opened, owner
        }
    }
    
    // MARK: - Competition
    struct Competition: Decodable {
        let id: Int
        let name: String
        let location: Location
    }
    
    // MARK: - Location
    struct Location: Decodable {
        let country: String
        let city: String
    }
    
    // MARK: - LapRecord
    struct LapRecord: Decodable {
        let time: String
        let driver: String
        let year: String
    }
}
