//
//  TeamDetailsViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation
import Domain

public protocol TeamDetailsViewModelDelegate: AnyObject {
    func teamDetailsFetched(_ teamDetails: [TeamDetailsEntity])
}

public final class TeamDetailsViewModel {
    //MARK: - Properties
    weak var delegate: TeamDetailsViewModelDelegate!
    public var getTeamDetailsUseCase: GetTeamDetailsUseCase!
    public let team: TeamsEntity
    public var teamDetails: [TeamDetailsEntity] = []
    
    //MARK: - Init
    public init(getTeamDetailsUseCase: GetTeamDetailsUseCase!, team: TeamsEntity) {
        self.getTeamDetailsUseCase = getTeamDetailsUseCase
        self.team = team
    }
    
    public func viewDidLoad() {
        fetchTeamDetails()
    }
    
    private func fetchTeamDetails() {
        getTeamDetailsUseCase.execute(for: team.constructorName) { [weak self] result in
            switch result {
            case .success(let teamDetails):
                DispatchQueue.main.async {
                    self?.teamDetails = teamDetails
                    self?.delegate.teamDetailsFetched(teamDetails)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

