//
//  DefaultDriverDetailsRepository.swift
//
//
//  Created by Bakar Kharabadze on 7/22/24.
//

import Foundation
import Domain
import Network
import Common

public final class DefaultDriverDetailsRepository {
    
    // MARK: - Properties
    private let dataTransferService: DataTransfer
    
    // MARK: - Initialization
    public init(dataTransferService: DataTransfer) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - DriverDetailsRepository
extension DefaultDriverDetailsRepository: DriverDetailsRepository {
    
    public func getCircuitDetails(for name: String, completion: @escaping (Result<[Domain.DriverDetailsEntity], any Error>) -> Void) -> (any Common.Cancellable)? {
        
        let endpoint = DriverDetailsAPIEndpoints.details(driversName: name)
        
        return self.dataTransferService.request(with: endpoint) { (response: Result<DriverDetailsResponse, Error>) in
            switch response {
            case .success(let driverDetailsResponse):
                let driverDetailsEntities = DriverDetailsEntity.map(driverDetailsResponse: driverDetailsResponse)
                completion(.success(driverDetailsEntities))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
