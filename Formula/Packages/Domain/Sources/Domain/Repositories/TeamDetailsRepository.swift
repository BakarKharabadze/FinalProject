//
//  TeamDetailsRepository.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation
import Common

public protocol TeamDetailsRepository {
    func getTeamDetails(for teamName: String, completion: @escaping (Result<[TeamDetailsEntity], Error>) -> Void) -> Cancellable?
}
