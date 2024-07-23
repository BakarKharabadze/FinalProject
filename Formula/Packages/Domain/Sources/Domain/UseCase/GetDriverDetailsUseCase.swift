//
//  GetDriverDetailsUseCase.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation
import Common

public protocol GetDriverDetailsUseCase {
    func execute(for name: String, completion: @escaping (Result<[DriverDetailsEntity], Error>) -> Void) -> Cancellable?
}

public final class DefaultGetDriversDetailsUseCase: GetDriverDetailsUseCase {
   
    private let repository: DriverDetailsRepository
    
    public init(repository: DriverDetailsRepository) {
        self.repository = repository
    }
    
    public func execute(for name: String, completion: @escaping (Result<[DriverDetailsEntity], any Error>) -> Void) -> Cancellable? {
        repository.getCircuitDetails(for: name, completion: completion)
    }
}
