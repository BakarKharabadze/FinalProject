//
//  DriverDetailsViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation
import Domain

public final class DriverDetailsViewModel {
    
    //MARK: - Properties
    let driver: DriverEntity
    
    //MARK: - Init
    public init(driver: DriverEntity) {
        self.driver = driver
    }
}
