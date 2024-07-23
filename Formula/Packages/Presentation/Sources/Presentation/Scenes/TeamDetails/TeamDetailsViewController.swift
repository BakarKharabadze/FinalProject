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
        setupUI()
        setupSwiftUIHosting()
    }
    
    // MARK: - Setup Functions
    private func setupUI() {
        setupScrollView()
        setupContentView()
        setupMainStackView()
        setupTeamNameStackView()
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
        teamNameStackView.spacing = 10
        
        teamNameLabel.font = .systemFont(ofSize: 30, weight: .bold)
        teamNameLabel.textColor = .white
        teamNameLabel.text = "Red Bull Racing"
        
        teamImageView.image = UIImage(systemName: "person.3.fill")
        teamImageView.tintColor = .white
        teamImageView.contentMode = .scaleAspectFit
        teamImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            teamImageView.widthAnchor.constraint(equalToConstant: 80),
            teamImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        teamNameStackView.addArrangedSubview(teamNameLabel)
        teamNameStackView.addArrangedSubview(teamImageView)
        
        mainStackView.addArrangedSubview(teamNameStackView)
    }
    
    // MARK: - SwiftUI Hosting
    private func setupSwiftUIHosting() {
        let swiftUIView = TeamDetailsSwiftUIView(team: TeamDetailsEntity(
            name: "Red Bull Racing",
            worldTitle: "4",
            raceWins: "92",
            polePositions: "100",
            fastesLaps: "50",
            base: "Milton Keynes, UK",
            president: "Christian Horner",
            director: "Adrian Newey",
            technicalManeger: "Pierre Waché"
        ))
        
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        addChild(hostingController)
        contentView.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 20),
            hostingController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}


#Preview {
    TeamDetailsViewController()
}
