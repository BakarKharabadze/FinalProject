//
//  GetCircuitDetailsUseCase.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//


import Foundation
import Common

public protocol GetCircuitDetailsUseCase {
    func execute(for circuitName: String, completion: @escaping (Result<[CircuitDetailsEntity], Error>) -> Void) -> Cancellable?
}
    
public final class DefaultGetCircuitDetailsUseCase: GetCircuitDetailsUseCase {
    
    private let repository: FormulaSportsRepository
    
    public init(repository: FormulaSportsRepository) {
        self.repository = repository
    }
    
    public func execute(for circuitName: String, completion: @escaping (Result<[CircuitDetailsEntity], any Error>) -> Void) -> (any Common.Cancellable)? {
        repository.getCircuitDetails(for: circuitName, completion: completion)
    }
}
