//
//  GetDriverDetailsUseCase.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation
import Common

public protocol GetDriverDetailsUseCase {
    func execute(completion: @escaping (Result<[DriverDetailsEntity], Error>) -> Void) -> Cancellable?
}

public class DefaultGetDriversDetailsUseCase: GetDriverDetailsUseCase {
   
    private let repository: DriverDetailsRepository
    
    public init(repository: DriverDetailsRepository) {
        self.repository = repository
    }
    
    public func execute(completion: @escaping (Result<[DriverDetailsEntity], any Error>) -> Void) -> Cancellable? {
        repository.getCircuitDetails(completion: completion)
    }
}
