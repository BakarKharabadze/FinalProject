//
//  DriversViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation
import Domain

public final class DriversViewModel {
    
    var drivers: [DriverEntity]
    
    public init(drivers: [DriverEntity]) {
        self.drivers = drivers
    }
}
