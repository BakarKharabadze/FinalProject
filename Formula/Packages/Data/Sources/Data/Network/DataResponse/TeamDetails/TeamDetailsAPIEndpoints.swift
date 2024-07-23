//
//  TeamDetailsAPIEndpoints.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation
import Domain
import Network

struct TeamDetailsAPIEndpoints {
    
    static func details(teamName: String) -> DataEndpoint<TeamDetailsResponse> {
        let firstWord = teamName.split(separator: " ").first?.lowercased() ?? ""
        return DataEndpoint(path: "teams",
                            queryParameters: ["search": firstWord],
                            headerParamaters: ["X-RapidAPI-Host": "api-formula-1.p.rapidapi.com"])
    }
}
