//
//  GetRaceResultUseCase.swift
//
//
//  Created by Bakar Kharabadze on 7/16/24.
//

import Foundation
import Common

public protocol GetRaceResultUseCase {
    func execute(completion: @escaping (Result<[RaceResultEntity], Error>) -> Void) -> Cancellable?
}

public final class DefaultGetRaceResultUseCase: GetRaceResultUseCase {
    
    private let repository: RaceResultRepository
    
    public init(repository: RaceResultRepository) {
        self.repository = repository
    }
    
    public func execute(completion: @escaping (Result<[RaceResultEntity], any Error>) -> Void) -> Cancellable? {
        repository.getRaceResult(result: completion)
    }
    
    
}
