//
//  File.swift
//  
//
//  Created by Bakar Kharabadze on 7/11/24.
//

import Foundation
import Domain
import Network

struct DriverAPIEndpoints {
    
    static func drivers() -> DataEndpoint<DriverStandings> {
           return DataEndpoint(path: "api/f1/current/driverStandings.json")
       }
}
