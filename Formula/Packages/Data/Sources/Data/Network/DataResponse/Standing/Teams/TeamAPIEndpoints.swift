//
//  TeamEndPoints.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation
import Domain
import Network

struct TeamAPIEndpoints {
    
    static func teams() -> DataEndpoint<TeamsStandings> {
        DataEndpoint(path: "api/f1/current/constructorStandings.json")
    }
}
