//
//  DefaultRacesRepository.swift
//
//
//  Created by Bakar Kharabadze on 7/10/24.
//

import Foundation
import Domain
import Network
import Common

public final class DefaultRacesRepository {
    
    // MARK: - Properties
    private let dataTransferService: DataTransfer
    
    // MARK: - Initialization
    public init(dataTransferService: DataTransfer) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - RaceRepository
extension DefaultRacesRepository: RaceRepository {
    public func getRaces(result: @escaping (Result<[RaceEntity], Error>) -> Void) -> Cancellable? {
        let endpoint = RaceAPIEndpoints.races()
        
        return self.dataTransferService.request(with: endpoint) { (response: Result<F1Season, Error>) in
            switch response {
            case .success(let f1Season):
                let races = f1Season.mrData.raceTable.races.map { race in
                    RaceEntity(
                        round: race.round,
                        grandPrixName: race.raceName,
                        date: race.date ?? "",
                        image: race.circuit?.url ?? "",
                        startsIn: race.time ?? "",
                        countryFlag: race.raceName,
                        circuitID: race.circuit?.circuitID ?? ""
                    )
                }
                result(.success(races))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
