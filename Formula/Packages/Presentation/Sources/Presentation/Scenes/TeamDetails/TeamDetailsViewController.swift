//
//  TeamDetailsViewController.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import UIKit
import SwiftUI
import Domain

public final class TeamDetailsViewController: UIViewController {
    
    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let mainStackView = UIStackView()
    private let teamNameLabel = UILabel()
    private let teamImageView = UIImageView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let errorMessageLabel = UILabel()
    
    private var viewModel: TeamDetailsViewModel!
    
    // MARK: - Initialization
    public class func create(with viewModel: TeamDetailsViewModel) -> TeamDetailsViewController {
        let vc = TeamDetailsViewController()
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
        viewModel.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup Functions
    private func setupUI() {
        setupScrollView()
        setupContentView()
        setupMainStackView()
        setupTeamNameStackView()
        setupActivityIndicator()
        setupErrorMessageLabel()
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
    
    private func setupTeamNameStackView() {
        let teamNameStackView = UIStackView()
        teamNameStackView.axis = .horizontal
        teamNameStackView.alignment = .center
        teamNameStackView.distribution = .fill
        teamNameStackView.spacing = 50
        
        teamNameLabel.font = .systemFont(ofSize: 30, weight: .bold)
        teamNameLabel.textColor = .white
        teamNameLabel.numberOfLines = 0
        
        teamImageView.tintColor = .white
        teamImageView.contentMode = .scaleAspectFit
        teamImageView.layer.cornerRadius = 10
        teamImageView.clipsToBounds = true
        
        teamImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            teamImageView.widthAnchor.constraint(equalToConstant: 150),
            teamImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        teamNameStackView.addArrangedSubview(teamNameLabel)
        teamNameStackView.addArrangedSubview(teamImageView)
        
        mainStackView.addArrangedSubview(teamNameStackView)
    }
    
    private func setupActivityIndicator() {
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupErrorMessageLabel() {
        errorMessageLabel.textColor = .red
        errorMessageLabel.font = .systemFont(ofSize: 20)
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true

        view.addSubview(errorMessageLabel)
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            errorMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorMessageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorMessageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorMessageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    public func showErrorText(message: String) {
        errorMessageLabel.text = message
        errorMessageLabel.isHidden = false
        activityIndicator.stopAnimating()
        scrollView.isHidden = true
    }
    
    // MARK: - SwiftUI Hosting
    private func setupSwiftUIHosting(with teamDetails: TeamDetailsEntity) {
        let swiftUIView = TeamDetailsSwiftUIView(teamDetails: teamDetails)
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
    
    // MARK: - Loader Functions
    public func showLoader() {
        activityIndicator.startAnimating()
        errorMessageLabel.isHidden = true
        scrollView.isHidden = false
    }
    
    public func hideLoader() {
        activityIndicator.stopAnimating()
    }
}

//MARK: - TeamDetailsViewModelDelegate
extension TeamDetailsViewController: TeamDetailsViewModelDelegate {
    public func teamDetailsFetched(_ teamDetails: [Domain.TeamDetailsEntity], logoData: Data?) {
        hideLoader()
        guard let firstTeam = teamDetails.first else { return }
        teamNameLabel.text = firstTeam.name
        if let data = logoData {
            teamImageView.image = UIImage(data: data)
        } else {
            teamImageView.image = UIImage(named: viewModel.team.constructorID, in: Bundle.module, with: nil)
        }
        
        setupSwiftUIHosting(with: firstTeam)
    }
    
    public func showError(message: String) {
        showErrorText(message: message)
    }
}
