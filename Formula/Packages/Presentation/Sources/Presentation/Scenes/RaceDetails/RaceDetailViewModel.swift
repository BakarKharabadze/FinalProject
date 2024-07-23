//
//  RaceDetailViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/14/24.
//

import Foundation
import Domain

//MARK: - RaceDetailViewModelDelegate
public protocol RaceDetailViewModelDelegate: AnyObject {
    func circuitFetched(_ circuit: [CircuitDetailsEntity])
}


public final class RaceDetailViewModel {
    
    //MARK: - Properties
    public let race: RaceEntity
    public let getCircuitDetailsUseCase: GetCircuitDetailsUseCase
    weak var delegate: RaceDetailViewModelDelegate?
    
    public var circuit: [CircuitDetailsEntity] = []
    
    //MARK: - Init
    public init(race: RaceEntity, getCircuitDetailsUseCase: GetCircuitDetailsUseCase) {
        self.race = race
        self.getCircuitDetailsUseCase = getCircuitDetailsUseCase
    }
    
    //MARK: - Methods
    public func viewDidLoad() {
        fetchCircuit()
    }
    
    private func fetchCircuit() {
        _ = getCircuitDetailsUseCase.execute(for: race.circuitID) { [weak self] result in
            switch result {
            case .success(let circuit):
                DispatchQueue.main.async {
                    self?.circuit = circuit
                    self?.delegate?.circuitFetched(circuit) 
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
