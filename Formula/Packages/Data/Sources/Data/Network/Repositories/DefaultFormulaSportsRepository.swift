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
    public func getCircuitDetails(for circuit: String, completion: @escaping (Result<[Domain.CircuitDetailsEntity], any Error>) -> Void) -> (any Common.Cancellable)? {
        let endpoint = CircuitDetailsAPIEndpoints.details(name: circuit)
        
        return self.dataTransferService.request(with: endpoint) { (response: Result<CircuitDetailsResponse, Error>) in
            switch response {
            case .success(let details):
               // completion(.success(CircuitDetailsEntity.map(circuitDetailsResponse: details)))
                completion(.success([]))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
