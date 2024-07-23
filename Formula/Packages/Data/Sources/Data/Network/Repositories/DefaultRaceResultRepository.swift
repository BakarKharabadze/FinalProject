//
//  DefaultRaceResultRepository.swift
//
//
//  Created by Bakar Kharabadze on 7/16/24.
//

import Foundation
import Domain
import Network
import Common

public final class DefaultRaceResultRepository {
    
    // MARK: - Properties
    private let dataTransferService: DataTransfer
    
    // MARK: - Initialization
    public init(dataTransferService: DataTransfer) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - RaceResultRepository
extension DefaultRaceResultRepository: RaceResultRepository {
    public func getRaceResult(result completion: @escaping (Result<[RaceResultEntity], any Error>) -> Void) -> Cancellable? {
        let endpoint = RaceLastResultsAPIEndpoints.race()
        
        return self.dataTransferService.request(with: endpoint) { (response: Result<RaceLastResults, Error>) in
            switch response {
            case .success(let raceResults):
                if let race = raceResults.mrData.raceTable.races.first,
                   let raceResultEntity = RaceResultEntity.map(race: race) {
                    completion(.success([raceResultEntity]))
                } else {
                    print("Completion failure")
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
