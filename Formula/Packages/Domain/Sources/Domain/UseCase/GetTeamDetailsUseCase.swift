//
//  GetTeamDetailsUseCase.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation
import Common

public protocol GetTeamDetailsUseCase {
    func execute(for teamName: String, completion: @escaping (Result<[TeamDetailsEntity], Error>) -> Void) -> Cancellable?
}

public final class DefaultGetTeamDetailsUseCase: GetTeamDetailsUseCase {
    
    private let repository: TeamDetailsRepository
    
    public init(repository: TeamDetailsRepository) {
        self.repository = repository
    }
    
    public func execute(for teamName: String, completion: @escaping (Result<[TeamDetailsEntity], any Error>) -> Void) -> (any Common.Cancellable)? {
        repository.getTeamDetails(for: teamName, completion: completion)
    }
}
