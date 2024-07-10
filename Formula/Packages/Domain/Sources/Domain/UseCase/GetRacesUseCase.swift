//
//  GetRacesUseCase.swift
//
//
//  Created by Bakar Kharabadze on 7/10/24.
//

import Foundation
import Common

public protocol GetRacesUseCase {
    func execute(completion: @escaping (Result<[RaceEntity], Error>) -> Void) -> Cancellable?
}

public final class DefaultGetRacesUseCase: GetRacesUseCase {
    
    private let repository: RaceRepository
    
    public init(repository: RaceRepository) {
        self.repository = repository
    }
    
    public func execute(completion: @escaping (Result<[RaceEntity], Error>) -> Void) -> Cancellable? {
        repository.getRaces(result: completion)
    }
}
