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
    
    static func details(circuitId: String) -> DataEndpoint<CircuitResponse> {
        DataEndpoint(path: "circuits",
                     queryParameters: ["search": circuitId],
                     headerParamaters: ["X-RapidAPI-Host": "api-formula-1.p.rapidapi.com"])
    }
}
