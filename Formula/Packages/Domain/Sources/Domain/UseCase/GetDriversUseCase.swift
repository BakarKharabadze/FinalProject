//
//  GetDriversUseCase.swift
//  
//
//  Created by Bakar Kharabadze on 7/11/24.
//

import Foundation
import Common

public protocol GetDriversUseCase {
    func execute(completion: @escaping (Result<[DriverEntity], Error>) -> Void) -> Cancellable?
}

public final class DefaultGetDriversUseCase: GetDriversUseCase {
    private let repository: DriversRepository
    
    public init(repository: DriversRepository) {
        self.repository = repository
    }
    
    
    public func execute(completion: @escaping (Result<[DriverEntity], any Error>) -> Void) -> Cancellable? {
        repository.getDrivers(completion: completion)
    }
}
