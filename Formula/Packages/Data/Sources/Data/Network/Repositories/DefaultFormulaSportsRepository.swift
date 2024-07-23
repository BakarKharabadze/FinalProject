//
//  DefaultFormulaSportsRepository.swift
//
//
//  Created by Bakar Kharabadze on 7/19/24.
//

import Foundation
import Domain
import Network
import Common

public final class DefaultFormulaSportsRepository {
    
    // MARK: - Properties
    private let dataTransferService: DataTransfer
    
    // MARK: - Initialization
    public init(dataTransferService: DataTransfer) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - FormulaSportsRepository
extension DefaultFormulaSportsRepository: FormulaSportsRepository {
    public func getCircuitDetails(for circuitId: String, completion: @escaping (Result<[Domain.CircuitDetailsEntity], any Error>) -> Void) -> (any Common.Cancellable)? {
        let endpoint = CircuitDetailsAPIEndpoints.details(circuitId: circuitId)
        
        return self.dataTransferService.request(with: endpoint) { (response: Result<CircuitResponse, Error>) in
            switch response {
            case .success(let details):
                let circuitDetailsEntities = CircuitDetailsEntity.map(circuitDetailsResponse: details)
                completion(.success(circuitDetailsEntities))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
