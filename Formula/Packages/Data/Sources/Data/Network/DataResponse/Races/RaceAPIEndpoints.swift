//
//  File.swift
//  
//
//  Created by Bakar Kharabadze on 7/10/24.
//

import Foundation
import Domain
import Network

struct RaceAPIEndpoints {
    
    static func races() -> DataEndpoint<F1Season> {
           return DataEndpoint(path: "api/f1/current.json")
       }
}
