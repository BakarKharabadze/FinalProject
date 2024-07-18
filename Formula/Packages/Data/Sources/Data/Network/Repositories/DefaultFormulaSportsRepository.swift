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
    private let dataTransferService: DataTransfer
    
    public init(dataTransferService: DataTransfer) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultFormulaSportsRepository: FormulaSportsRepository {
    public func getCircuitDetails(for circuit: String, completion: @escaping (Result<[Domain.CircuitDetailsEntity], any Error>) -> Void) -> (any Common.Cancellable)? {
        let endpoint = CircuitDetailsAPIEndpoints.details(name: circuit)
        
        return self.dataTransferService.request(with: endpoint) { (response: Result<CircuitDetailsResponse, Error>) in
            switch response {
            case .success(let details):
               // result(.success(CircuitDetailsEntity.map(circuitDetailsResponse: details)))
                completion(.success([]))
                return
            case .failure(let error):
                completion(.failure(error))
                return
            }
        }
    }
}
