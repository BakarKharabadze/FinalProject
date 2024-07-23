//
//  DefaultTeamDetailsRepository.swift
//
//
//  Created by Bakar Kharabadze on 7/23/24.
//

import Foundation
import Domain
import Network
import Common

public final class DefaultTeamDetailsRepository {
    
    // MARK: - Properties
    private let dataTransferService: DataTransfer
    
    // MARK: - Initialization
    public init(dataTransferService: DataTransfer) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - TeamDetailsRepository
extension DefaultTeamDetailsRepository: TeamDetailsRepository {
    public func getTeamDetails(for teamName: String, completion: @escaping (Result<[Domain.TeamDetailsEntity], any Error>) -> Void) -> (any Common.Cancellable)? {
        let endpoint = TeamDetailsAPIEndpoints.details(teamName: teamName)
        
        return self.dataTransferService.request(with: endpoint) { (response: Result<TeamDetailsResponse, Error>) in
            switch response {
            case .success(let teamDetailsResponse):
                let teamDetailsEntities = TeamDetailsEntity.map(teamDetailsResponse: teamDetailsResponse)
                completion(.success(teamDetailsEntities))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
