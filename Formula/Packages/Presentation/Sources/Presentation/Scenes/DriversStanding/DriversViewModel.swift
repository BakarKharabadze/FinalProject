//
//  DriversViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import Foundation
import Domain
import UIKit

public final class DriversViewModel {
    
    var drivers: [DriverEntity]
    
    public init(drivers: [DriverEntity]) {
        self.drivers = drivers
    }
    
    public func getColorForTeam(_ team: String) -> UIColor {
        switch team {
        case "Red Bull":
            return UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 2.0)
        case "Ferrari":
            return UIColor.red
        case "Mercedes":
            return UIColor.green
        case "McLaren":
            return UIColor.orange
        case "Aston Martin":
            return UIColor.green
        case "Alpine":
            return UIColor.blue
        case "AlphaTauri":
            return UIColor.white
        case "Alfa Romeo":
            return UIColor.red
        case "Williams":
            return UIColor.blue
        case "Haas":
            return UIColor.white
        default:
            return UIColor.white
        }
    }
}
