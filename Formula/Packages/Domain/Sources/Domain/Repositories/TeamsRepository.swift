//
//  TeamsRepository.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation
import Common

public protocol TeamsRepository {
    func getTeams(completion: @escaping (Result<[TeamsEntity], Error>) -> Void) -> Cancellable?
}
