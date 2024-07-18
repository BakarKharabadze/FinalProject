//
//  DriverDetailsRepository.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation
import Common

public protocol DriverDetailsRepository {
    func getCircuitDetails(completion: @escaping (Result<[DriverDetailsEntity], Error>) -> Void) -> Cancellable?
}
