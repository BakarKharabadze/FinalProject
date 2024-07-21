//
//  RaceResponse.swift
//
//
//  Created by Bakar Kharabadze on 7/10/24.
//

import Foundation

// MARK: - F1Season
public struct F1Season: Decodable {
    public let mrData: MRData
    
    public enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
    
    // MARK: - MRData
    public struct MRData: Decodable {
        public let series: String
        public let url: String
        public let limit, offset, total: String
        public let raceTable: RaceTable
        
        public enum CodingKeys: String, CodingKey {
            case series, url, limit, offset, total
            case raceTable = "RaceTable"
        }
    }
    
    // MARK: - RaceTable
    public struct RaceTable: Decodable {
        public let season: String
        public let races: [Race]
        
        public enum CodingKeys: String, CodingKey {
            case season
            case races = "Races"
        }
    }
    
    // MARK: - Race
    public struct Race: Decodable {
        public let season: String
        public let round: String
        public let url: String
        public let raceName: String
        public let circuit: Circuit?
        public let date, time: String?
        public let firstPractice, secondPractice, thirdPractice, qualifying: Practice?
        public let sprint: Practice?
        
        public enum CodingKeys: String, CodingKey {
            case season, round, url, raceName, circuit, date, time
            case firstPractice = "FirstPractice"
            case secondPractice = "SecondPractice"
            case thirdPractice = "ThirdPractice"
            case qualifying = "Qualifying"
            case sprint = "Sprint"
        }
    }
    
    // MARK: - Circuit
    public struct Circuit: Decodable {
        public let circuitID: String
        public let url: String
        public let circuitName: String
        public let location: Location
        
        public enum CodingKeys: String, CodingKey {
            case circuitID = "circuitId"
            case url, circuitName, location
        }
    }
    
    // MARK: - Location
    public struct Location: Decodable {
        public let lat, long: String
        public let locality, country: String
        
        public enum CodingKeys: String, CodingKey {
            case lat = "lat"
            case long = "long"
            case locality, country
        }
    }
    
    // MARK: - Practice
    public struct Practice: Decodable {
        public let date, time: String?
    }
}
