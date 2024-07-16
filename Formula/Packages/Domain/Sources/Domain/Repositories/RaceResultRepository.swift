//
//  RaceResultRepository.swift
//
//
//  Created by Bakar Kharabadze on 7/16/24.
//

import Foundation
import Common

public protocol RaceResultRepository {
    func getRaceResult(result: @escaping (Result<[RaceResultEntity], Error>) -> Void) -> Cancellable?
}
