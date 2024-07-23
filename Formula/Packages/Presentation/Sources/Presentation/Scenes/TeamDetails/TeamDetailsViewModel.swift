//
//  TeamDetailsViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation
import Domain

public protocol TeamDetailsViewModelDelegate: AnyObject {
    func teamDetailsFetched(_ teamDetails: [TeamDetailsEntity], logoData: Data?)
}

public final class TeamDetailsViewModel {
    //MARK: - Properties
    weak var delegate: TeamDetailsViewModelDelegate?
    public var getTeamDetailsUseCase: GetTeamDetailsUseCase
    public let team: TeamsEntity
    public var teamDetails: [TeamDetailsEntity] = []
    
    //MARK: - Init
    public init(getTeamDetailsUseCase: GetTeamDetailsUseCase, team: TeamsEntity) {
        self.getTeamDetailsUseCase = getTeamDetailsUseCase
        self.team = team
    }
    
    public func viewDidLoad() {
        fetchTeamDetails()
    }
    
    private func fetchTeamDetails() {
        _ = getTeamDetailsUseCase.execute(for: team.constructorName) { [weak self] result in
            switch result {
            case .success(let teamDetails):
                self?.teamDetails = teamDetails
                self?.fetchTeamLogo()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchTeamLogo() {
        guard let logoUrlString = teamDetails.first?.logo, let logoUrl = URL(string: logoUrlString) else {
            delegate?.teamDetailsFetched(teamDetails, logoData: nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: logoUrl) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.delegate?.teamDetailsFetched(self?.teamDetails ?? [], logoData: data)
            }
        }
        task.resume()
    }
}
