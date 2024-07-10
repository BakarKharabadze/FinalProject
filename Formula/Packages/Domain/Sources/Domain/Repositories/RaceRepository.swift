//
//  RaceRepository.swift
//
//
//  Created by Bakar Kharabadze on 7/10/24.
//

import Foundation
import Common

public protocol RaceRepository {
    func getRaces(result: @escaping (Result<[RaceEntity], Error>) -> Void) -> Cancellable?
}
