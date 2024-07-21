//
//  DefaultTeamsRepository.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation
import Domain
import Network
import Common

public final class DefaultTeamsRepository {
    
    // MARK: - Properties
    private let dataTransferService: DataTransfer
    
    // MARK: - Initialization
    public init(dataTransferService: DataTransfer) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - TeamsRepository
extension DefaultTeamsRepository: TeamsRepository {
    public func getTeams(completion: @escaping (Result<[TeamsEntity], any Error>) -> Void) -> Cancellable? {
        let endpoint = TeamAPIEndpoints.teams()
        
        return self.dataTransferService.request(with: endpoint) { (response: Result<TeamsStandings, Error>) in
            switch response {
            case .success(let teams):
                guard let firstStandingsList = teams.mrData.standingsTable.standingsLists.first?.constructorStandings else {
                    print("Completion failure")
                    return
                }
                let teamEntities = TeamsEntity.map(teamResponse: firstStandingsList)
                completion(.success(teamEntities))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
