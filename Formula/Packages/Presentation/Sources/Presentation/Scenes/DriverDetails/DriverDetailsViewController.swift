//
//  DriverDetailsViewController.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import UIKit
import SwiftUI
import Domain

public final class DriverDetailsViewController: UIViewController {
    
    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let mainStackView = UIStackView()
    private let driverNameLabel = UILabel()
    private let driverNumberLabel = UILabel()
    private let teamNameLabel = UILabel()
    private let driverImageView = UIImageView()
    
    private var viewModel: DriverDetailsViewModel!
    
    // MARK: - Initialization
    public class func create(with viewModel: DriverDetailsViewModel) -> DriverDetailsViewController {
        let vc = DriverDetailsViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "CustomBackground")
        navigationController?.navigationBar.barTintColor = UIColor(named: "CustomBackground")
        navigationController?.setNavigationBarHidden(false, animated: false)
        viewModel.delegate = self
        setupUI()
        viewModel.viewDidLoad()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        setupScrollView()
        setupContentView()
        setupMainStackView()
        setupDriverNameLabel()
        setupDriverNumberLabel()
        setupTeamNameLabel()
        setupDriverImage()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupContentView() {
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor(named: "CustomBackground")
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupMainStackView() {
        contentView.addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.alignment = .leading
        mainStackView.distribution = .fill
        mainStackView.spacing = 20
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50)
        ])
    }
    
    private func setupDriverNameLabel() {
        driverNameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        driverNameLabel.textColor = .white
        driverNameLabel.numberOfLines = 0
        
        mainStackView.addArrangedSubview(driverNameLabel)
    }
    
    private func setupDriverNumberLabel() {
        driverNumberLabel.font = .systemFont(ofSize: 20)
        driverNumberLabel.textColor = .yellow
        
        mainStackView.addArrangedSubview(driverNumberLabel)
    }
    
    private func setupTeamNameLabel() {
        teamNameLabel.font = .systemFont(ofSize: 16)
        teamNameLabel.textColor = .lightGray
        teamNameLabel.numberOfLines = 0
        
        mainStackView.addArrangedSubview(teamNameLabel)
    }
    
    private func setupDriverImage() {
        view.addSubview(driverImageView)
        
        driverImageView.tintColor = .white
        driverImageView.contentMode = .scaleAspectFit
        driverImageView.layer.cornerRadius = 20
        driverImageView.clipsToBounds = true
        driverImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            driverImageView.widthAnchor.constraint(equalToConstant: 150),
            driverImageView.heightAnchor.constraint(equalToConstant: 150),
            driverImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            driverImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
    }
    
    // MARK: - SwiftUI Hosting
    private func setupSwiftUIHosting(with driverDetails: DriverDetailsEntity) {
        let swiftUIView = DriverDetailsSwiftUIView(driverDetails: driverDetails)
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        addChild(hostingController)
        contentView.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        hostingController.view.backgroundColor = .clear
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 20),
            hostingController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

//MARK: - DriverDetailsViewModelDelegate
extension DriverDetailsViewController: DriverDetailsViewModelDelegate {
    public func driverDetailsFetched(_ driverDetails: [DriverDetailsEntity]) {
        guard let firstDriver = driverDetails.first else { return }
        driverNameLabel.text = firstDriver.name
        driverNumberLabel.text = "Driver Number \(firstDriver.driverNumber)"
        teamNameLabel.text = firstDriver.teamName
        driverImageView.image = UIImage(named: viewModel.driver.familyName, in: Bundle.module, with: nil)
        
        setupSwiftUIHosting(with: firstDriver)
    }
}
