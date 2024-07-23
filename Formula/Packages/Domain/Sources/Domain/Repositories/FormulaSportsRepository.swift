//
//  FormulaSportsRepository.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation
import Common

public protocol FormulaSportsRepository {
    func getCircuitDetails(for circuitId: String, completion: @escaping (Result<[CircuitDetailsEntity], Error>) -> Void) -> Cancellable?
}
