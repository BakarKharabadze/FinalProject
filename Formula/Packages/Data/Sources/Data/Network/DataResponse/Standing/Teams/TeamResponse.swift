//
//  TeamResponse.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation

// MARK: - Welcome
public struct TeamsStandings: Codable {
    public let mrData: MRData
    
    public enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
    
    // MARK: - MRData
    public struct MRData: Codable {
        public let xmlns: String
        public let series: String
        public let url: String
        public let limit, offset, total: String
        public let standingsTable: StandingsTable
        
        public enum CodingKeys: String, CodingKey {
            case xmlns, series, url, limit, offset, total
            case standingsTable = "StandingsTable"
        }
    }
    
    // MARK: - StandingsTable
    public struct StandingsTable: Codable {
        public let season: String
        public let standingsLists: [StandingsList]
        
        public enum CodingKeys: String, CodingKey {
            case season
            case standingsLists = "StandingsLists"
        }
    }
    
    // MARK: - StandingsList
    public struct StandingsList: Codable {
        public let season, round: String
        public let constructorStandings: [ConstructorStanding]
        
        public enum CodingKeys: String, CodingKey {
            case season, round
            case constructorStandings = "ConstructorStandings"
        }
    }
    
    // MARK: - ConstructorStanding
    public struct ConstructorStanding: Codable {
        public let position, positionText, points, wins: String
        public let constructor: Constructor
        
        public enum CodingKeys: String, CodingKey {
            case position, positionText, points, wins
            case constructor = "Constructor"
        }
    }
    
    // MARK: - Constructor
    public struct Constructor: Codable {
        public let constructorID: String
        public let url: String
        public let name, nationality: String
        
        public enum CodingKeys: String, CodingKey {
            case constructorID = "constructorId"
            case url, name, nationality
        }
    }
}
