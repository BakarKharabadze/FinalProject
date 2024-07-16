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

public final class DefaultRaceResultRepository  {
    
    private let dataTransferService: DataTransfer
    
    public init(dataTransferService: DataTransfer) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultRaceResultRepository: RaceResultRepository {
    public func getRaceResult(result completion: @escaping (Result<[RaceResultEntity], any Error>) -> Void) -> Cancellable? {
        let endpoint = RaceLastResultsAPIEndpoints.race()
        
        return self.dataTransferService.request(with: endpoint) { (response: Result<RaceLastResults, Error>) in
            switch response {
            case .success(let raceResults):
                guard let race = raceResults.mrData.raceTable.races.first else {
                    print("Error")
                    return
                }
                if let raceResultEntity = RaceResultEntity.map(race: race) {
                    completion(.success([raceResultEntity]))
                } else {
                    print("Error")
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

