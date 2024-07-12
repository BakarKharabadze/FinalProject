//
//  File.swift
//  
//
//  Created by Bakar Kharabadze on 7/11/24.
//

import Foundation
import Common

public protocol DriversRepository {
    func getDrivers(completion: @escaping (Result<[DriverEntity], Error>) -> Void) -> Cancellable?
}
