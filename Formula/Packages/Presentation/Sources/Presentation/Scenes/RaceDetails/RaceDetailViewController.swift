//
//  RaceDetailViewController.swift
//
//
//  Created by Bakar Kharabadze on 7/14/24.
//

import UIKit
import SwiftUI
import Domain

final public class RaceDetailViewController: UIViewController {
    
    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let mainStackView = UIStackView()
    private let countryNameLabel = UILabel()
    private let grandPrixNameLabel = UILabel()
    private let dateLabel = UILabel()
    private let circuitLenghtLabel = UILabel()
    private let circuitLentght = UILabel()
    private let distanceTitleLabel = UILabel()
    private let circuitDistanceLabel = UILabel()
    private let lapsLabel = UILabel()
    private let lapsQuantity = UILabel()
    private let raceWeekendContainer = UIView()
    private let circuitMapImageView = UIImageView()
    private let horizontalStackView = UIStackView()
    private let infoStackView = UIStackView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let errorMessageLabel = UILabel()
    
    private var viewModel: RaceDetailViewModel!
    
    // MARK: - Initialization
    public class func create(with viewModel: RaceDetailViewModel) -> RaceDetailViewController {
        let vc = RaceDetailViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "CustomBackground")
        navigationController?.navigationBar.barTintColor = UIColor(named: "CustomBackground")
        navigationController?.setNavigationBarHidden(false, animated: false)
        setupUI()
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        setupScrollView()
        setupContentView()
        setupMainStackView()
        setupCountryNameLabel()
        setupGrandPrixNameLabel()
        setupDateLabel()
        setupDistanceTitleLabel()
        setupCircuitDistanceLabel()
        setupCircuitLenghtLabel()
        setupDistanceLabel()
        setupCircuitMapImageView()
        setupRaceWeekendContainer()
        setupCustomSpacing()
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
        mainStackView.spacing = 10
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupCustomSpacing() {
        mainStackView.setCustomSpacing(20, after: dateLabel)
        mainStackView.setCustomSpacing(3, after: circuitLenghtLabel)
        mainStackView.setCustomSpacing(3, after: distanceTitleLabel)
        mainStackView.setCustomSpacing(10, after: circuitLentght)
        mainStackView.setCustomSpacing(20, after: horizontalStackView)
    }
    
    private func setupCountryNameLabel() {
        countryNameLabel.textColor = .white
        countryNameLabel.font = .systemFont(ofSize: 26, weight: .bold)
        
        mainStackView.addArrangedSubview(countryNameLabel)
    }
    
    private func setupGrandPrixNameLabel() {
        grandPrixNameLabel.font = .systemFont(ofSize: 24)
        grandPrixNameLabel.textColor = .yellow
        
        mainStackView.addArrangedSubview(grandPrixNameLabel)
    }
    
    private func setupDateLabel() {
        dateLabel.font = .systemFont(ofSize: 20)
        dateLabel.textColor = .lightGray
        
        mainStackView.addArrangedSubview(dateLabel)
    }
    
    private func setupDistanceTitleLabel() {
        distanceTitleLabel.text = "Circuit Distance"
        distanceTitleLabel.font = .systemFont(ofSize: 16)
        distanceTitleLabel.textColor = .gray
        
        mainStackView.addArrangedSubview(distanceTitleLabel)
    }
    
    private func setupCircuitDistanceLabel() {
        circuitDistanceLabel.font = .systemFont(ofSize: 30, weight: .bold)
        circuitDistanceLabel.textColor = .white
        
        mainStackView.addArrangedSubview(circuitDistanceLabel)
    }
    
    private func setupCircuitLenghtLabel() {
        circuitLenghtLabel.font = .systemFont(ofSize: 16)
        circuitLenghtLabel.textColor = .gray
        
        mainStackView.addArrangedSubview(circuitLenghtLabel)
    }
    
    private func setupDistanceLabel() {
        circuitLentght.font = .systemFont(ofSize: 30, weight: .bold)
        circuitLentght.textColor = .white
        
        mainStackView.addArrangedSubview(circuitLentght)
    }
    
    private func setupCircuitMapImageView() {
        circuitMapImageView.contentMode = .scaleAspectFit
        circuitMapImageView.tintColor = .systemBlue
        circuitMapImageView.translatesAutoresizingMaskIntoConstraints = false
        
        infoStackView.axis = .vertical
        infoStackView.alignment = .leading
        infoStackView.spacing = 20
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .top
        horizontalStackView.distribution = .fill
        horizontalStackView.spacing = 20
        
        [setupLapsLabel, setupLapsQuantity].forEach { method in
            method()
            if let lastView = infoStackView.arrangedSubviews.last {
                infoStackView.setCustomSpacing(3, after: lastView)
            }
        }
        
        horizontalStackView.addArrangedSubview(infoStackView)
        horizontalStackView.addArrangedSubview(circuitMapImageView)
        
        mainStackView.addArrangedSubview(horizontalStackView)
        
        NSLayoutConstraint.activate([
            circuitMapImageView.widthAnchor.constraint(equalToConstant: 200),
            circuitMapImageView.heightAnchor.constraint(equalToConstant: 200),
            horizontalStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
        ])
    }
    
    private func setupLapsLabel() {
        lapsLabel.text = "N. of laps"
        lapsLabel.font = .systemFont(ofSize: 16)
        lapsLabel.textColor = .gray
        
        infoStackView.addArrangedSubview(lapsLabel)
    }
    
    private func setupLapsQuantity() {
        lapsQuantity.font = .systemFont(ofSize: 30, weight: .bold)
        lapsQuantity.textColor = .white
        
        infoStackView.addArrangedSubview(lapsQuantity)
    }
    
    private func setupRaceWeekendContainer() {
        raceWeekendContainer.layer.cornerRadius = 20
        raceWeekendContainer.layer.masksToBounds = true
        mainStackView.addArrangedSubview(raceWeekendContainer)
        
        let hostingController = UIHostingController(rootView: RaceWeekendView(race: viewModel.race))
        hostingController.view.backgroundColor = .clear
        
        addChild(hostingController)
        raceWeekendContainer.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: raceWeekendContainer.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: raceWeekendContainer.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: raceWeekendContainer.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: raceWeekendContainer.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            raceWeekendContainer.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: -17),
            raceWeekendContainer.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 17)
        ])
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        
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
}

extension RaceDetailViewController: RaceDetailViewModelDelegate {
    public func showError(message: String) {
        showErrorText(message: message)
    }
    
    public func circuitFetched(_ circuit: [Domain.CircuitDetailsEntity]) {
        activityIndicator.stopAnimating()
        guard let firstCircuit = circuit.first else { return }
        countryNameLabel.text = firstCircuit.countryName
        grandPrixNameLabel.text = firstCircuit.grandPrixName
        dateLabel.text = "Opened in \(firstCircuit.date) year"
        circuitLenghtLabel.text = "Circuit Length"
        circuitLentght.text = firstCircuit.circuitLenght
        circuitDistanceLabel.text = firstCircuit.raceDistance
        lapsQuantity.text = firstCircuit.laps
        circuitMapImageView.image = UIImage(named: viewModel.race.round, in: Bundle.module, with: nil)
    }
    
    public func showLoading() {
        activityIndicator.startAnimating()
        errorMessageLabel.isHidden = true
        scrollView.isHidden = false
    }
}
