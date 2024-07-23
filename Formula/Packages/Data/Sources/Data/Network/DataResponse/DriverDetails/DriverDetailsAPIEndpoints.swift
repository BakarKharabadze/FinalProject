//
//  DriverDetailsAPIEndpoints.swift
//  
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation
import Domain
import Network

struct DriverDetailsAPIEndpoints {
    
    static func details(driversName: String) -> DataEndpoint<DriverDetailsResponse> {
        DataEndpoint(path: "drivers",
                     queryParameters: ["search": driversName],
                     headerParamaters: ["X-RapidAPI-Host": "api-formula-1.p.rapidapi.com"])
    }
}
