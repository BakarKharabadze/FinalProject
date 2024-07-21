//
//  CircuitDetailsAPIEndpoints.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation
import Domain
import Network

struct CircuitDetailsAPIEndpoints {
    
    static func details(name: String) -> DataEndpoint<CircuitDetailsResponse> {
        
        DataEndpoint(path: "circuits",
                     queryParameters: ["search": name],
                     headerParamaters: ["X-RapidAPI-Host": "api-formula-1.p.rapidapi.com"])
    }
}
