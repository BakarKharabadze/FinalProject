//
//  GetTeamsUseCase.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation
import Common

public protocol GetTeamsUseCase {
    func execute(completion: @escaping (Result<[TeamsEntity], Error>) -> Void) -> Cancellable?
}

public final class DefaultGetTeamsUseCase: GetTeamsUseCase {
    
    private let repository: TeamsRepository
    
    public init(repository: TeamsRepository) {
        self.repository = repository
    }
    
    public func execute(completion: @escaping (Result<[TeamsEntity], any Error>) -> Void) -> Cancellable? {
        repository.getTeams(completion: completion)
    }
    
    
}
