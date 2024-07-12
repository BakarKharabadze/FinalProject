//
//  DefaultDriversRepository.swift
//  
//
//  Created by Bakar Kharabadze on 7/11/24.
//

import Foundation
import Domain
import Network
import Common

public final class DefaultDriversRepository {
    private let dataTransferService: DataTransfer
    
    public init(dataTransferService: DataTransfer) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultDriversRepository: DriversRepository {
    public func getDrivers(completion: @escaping (Result<[DriverEntity], any Error>) -> Void) -> Cancellable? {
        let endpoint = DriverAPIEndpoints.drivers()
        
        return self.dataTransferService.request(with: endpoint) { (response: Result<DriverStandings, Error>) in
            switch response {
            case .success(let driverStandings):
                guard let firstStandingsList = driverStandings.mrData.standingsTable.standingsLists.first else {
                    print("Error")
                    return
                }
                
                let driverEntities = DriverEntity.map(driverResponse: firstStandingsList.driverStandings)
                completion(.success(driverEntities))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
