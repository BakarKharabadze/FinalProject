//
//  RaceDetailViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/14/24.
//

import Foundation
import Domain

public final class RaceDetailViewModel {
    public let race: RaceEntity
    public let getCircuitDetailsUseCase: GetCircuitDetailsUseCase
    
    public init(race: RaceEntity, getCircuitDetailsUseCase: GetCircuitDetailsUseCase) {
        self.race = race
        self.getCircuitDetailsUseCase = getCircuitDetailsUseCase
    }
    
    public func viewDidLoad() {
        getCircuitDetailsUseCase.execute(for: race.circuitID) { [weak self] result in
            switch result {
            case .success(let details):
                print(details)
            case .failure(let error):
                print(error)
            }
        }
    }
}
