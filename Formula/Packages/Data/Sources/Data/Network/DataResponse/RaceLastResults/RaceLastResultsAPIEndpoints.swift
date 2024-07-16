//
//  RaceLastResultsAPIEndpoints.swift
//
//
//  Created by Bakar Kharabadze on 7/16/24.
//

import Foundation
import Domain
import Network

public struct RaceLastResultsAPIEndpoints {
    
    static func race() -> DataEndpoint<RaceLastResults> {
           return DataEndpoint(path: "api/f1/current/last/results.json")
       }
}
