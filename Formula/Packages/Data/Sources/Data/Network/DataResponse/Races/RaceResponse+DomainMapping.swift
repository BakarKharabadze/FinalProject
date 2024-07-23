//
//  RaceResponse+DomainMapping.swift
//
//
//  Created by Bakar Kharabadze on 7/10/24.
//

import Foundation
import Domain

extension RaceEntity {
    static func map(raceResponse: [F1Season.Race]) -> [RaceEntity] {
        raceResponse.map { race in
            RaceEntity(
                round: race.round,
                grandPrixName: race.raceName,
                circuitName: race.circuit?.circuitName ?? "",
                date: race.date ?? "",
                time: race.time ?? "",
                image: race.circuit?.url ?? "",
                startsIn: race.time ?? "",
                countryFlag: race.circuit?.location.country ?? "",
                circuitID: race.circuit?.circuitID ?? "",
                turns: "",
                topSpeed: "",
                practiceOneDate: race.firstPractice?.date ?? "",
                practiceOneTime: race.firstPractice?.time ?? "",
                practiceTwoDate: race.secondPractice?.date ?? "",
                practiceTwoTime: race.secondPractice?.time ?? "",
                practiceThreeDate: race.thirdPractice?.date ?? "",
                practiceThreeTime: race.thirdPractice?.time ?? "",
                qualificationDate: race.qualifying?.date ?? "",
                qualificationTime: race.qualifying?.time ?? ""
            )
        }
    }
}
