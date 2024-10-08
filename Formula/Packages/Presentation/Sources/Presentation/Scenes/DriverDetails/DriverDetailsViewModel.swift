//
//  DriverDetailsViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import Foundation
import Domain

//MARK: -DriverDetailsViewModelDelegate
public protocol DriverDetailsViewModelDelegate: AnyObject {
    func driverDetailsFetched(_ driverDetails: [DriverDetailsEntity])
    func showLoading()
    func showError(message: String)
}

public final class DriverDetailsViewModel {
    
    //MARK: - Properties
    weak var delegate: DriverDetailsViewModelDelegate?
    public let driver: DriverEntity
    public var driverDetails: [DriverDetailsEntity] = []
    public var getDriverDetailsUseCase: GetDriverDetailsUseCase
    
    //MARK: - Init
    public init(driver: DriverEntity, getDriverDetailsUseCase: GetDriverDetailsUseCase) {
        self.driver = driver
        self.getDriverDetailsUseCase = getDriverDetailsUseCase
    }
    
    //MARK: - Methods
    public func viewDidLoad() {
        delegate?.showLoading()
        fetchDriverDetails()
    }
    
    private func fetchDriverDetails() {
       _ = getDriverDetailsUseCase.execute(for: driver.givenName + " " + driver.familyName, completion: { [weak self] result in
            switch result {
            case .success(let driverDetails):
                DispatchQueue.main.async {
                    self?.driverDetails = driverDetails
                    self?.delegate?.driverDetailsFetched(driverDetails)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.delegate?.showError(message: "Failed to load driver details. Please try again later.")
                }
                print(error)
            }
        })
    }
}
