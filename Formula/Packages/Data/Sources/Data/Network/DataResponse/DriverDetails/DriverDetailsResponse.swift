//
//  DriverDetailsResponse.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation

// MARK: - DriverDetailsResponse
struct DriverDetailsResponse: Decodable {
    let get: String
    let parameters: Parameters
    let errors: [String]
    let results: Int
    let response: [Driver]
    
    // MARK: - Parameters
    struct Parameters: Decodable {
        let search: String
    }
    
    // MARK: - Driver
    struct Driver: Decodable {
        let id: Int
        let name: String
        let abbr: String
        let image: String
        let nationality: String
        let country: Country
        let birthdate: String
        let birthplace: String
        let number: Int
        let grandsPrixEntered: Int
        let worldChampionships: Int
        let podiums: Int
        let highestRaceFinish: HighestRaceFinish
        let highestGridPosition: Int
        let careerPoints: String
        let teams: [TeamSeason]
        
        enum CodingKeys: String, CodingKey {
            case id, name, abbr, image, nationality, country, birthdate, birthplace, number
            case grandsPrixEntered = "grands_prix_entered"
            case worldChampionships = "world_championships"
            case podiums
            case highestRaceFinish = "highest_race_finish"
            case highestGridPosition = "highest_grid_position"
            case careerPoints = "career_points"
            case teams
        }
    }
    
    // MARK: - Country
    struct Country: Decodable {
        let name: String
        let code: String
    }
    
    // MARK: - HighestRaceFinish
    struct HighestRaceFinish: Decodable {
        let position: Int
        let number: Int
    }
    
    // MARK: - TeamSeason
    struct TeamSeason: Decodable {
        let season: Int
        let team: Team
    }
    
    // MARK: - Team
    struct Team: Decodable {
        let id: Int
        let name: String
        let logo: String
    }
}
