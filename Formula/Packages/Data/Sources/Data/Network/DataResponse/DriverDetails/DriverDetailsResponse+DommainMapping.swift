//
//  DriverDetailsResponse+DomainMapping.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation
import Domain

extension DriverDetailsEntity {
    static func map(driverDetailsResponse: DriverDetailsResponse) -> [DriverDetailsEntity] {
        driverDetailsResponse.response.map { driver in
            DriverDetailsEntity(
                name: driver.name,
                driverNumber: "\(driver.number)",
                teamName: driver.teams.first?.team.name ?? "",
                races: "\(driver.grandsPrixEntered)",
                worldTitle: "\(driver.worldChampionships)",
                raceWins: "\(driver.highestRaceFinish.number)",
                podiums: "\(driver.podiums)",
                nationality: driver.nationality,
                birthday: driver.birthdate,
                birthPlace: driver.birthplace
            )
        }
    }
}
