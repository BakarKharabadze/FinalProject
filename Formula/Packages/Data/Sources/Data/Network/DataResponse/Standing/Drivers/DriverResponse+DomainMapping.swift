//
//  File.swift
//  
//
//  Created by Bakar Kharabadze on 7/11/24.
//

import Foundation
import Domain

extension DriverEntity {
    static func map(driverResponse: [DriverStandings.DriverStanding]) -> [DriverEntity] {
        return driverResponse.map { driver in
           DriverEntity(
            driverId: driver.driver.driverID ,
            position: driver.position,
            givenName: driver.driver.givenName,
            familyName: driver.driver.familyName,
            constructorName: driver.constructors.first?.name ?? "",
            points: driver.points
           )
            
        }
    }
}
