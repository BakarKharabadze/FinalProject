//
//  TeamDetailsResponse.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation

// MARK: - TeamDetailsResponse
struct TeamDetailsResponse: Decodable {
    let get: String
    let parameters: Parameters?
    let errors: [String]
    let results: Int
    let response: [Team]
    
    // MARK: - Parameters
    struct Parameters: Decodable {
        let id: String?
    }
    
    // MARK: - Team
    struct Team: Decodable {
        let id: Int
        let name: String
        let logo: String
        let base: String
        let firstTeamEntry: Int
        let worldChampionships: Int
        let highestRaceFinish: HighestRaceFinish
        let polePositions: Int
        let fastestLaps: Int
        let president: String
        let director: String
        let technicalManager: String
        let chassis: String
        let engine: String
        let tyres: String
        
        enum CodingKeys: String, CodingKey {
            case id, name, logo, base
            case firstTeamEntry = "first_team_entry"
            case worldChampionships = "world_championships"
            case highestRaceFinish = "highest_race_finish"
            case polePositions = "pole_positions"
            case fastestLaps = "fastest_laps"
            case president, director
            case technicalManager = "technical_manager"
            case chassis, engine, tyres
        }
    }
    
    // MARK: - HighestRaceFinish
    struct HighestRaceFinish: Decodable {
        let position: Int
        let number: Int
    }
}
