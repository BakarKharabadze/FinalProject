//
//  ScheduleViewController.swift
//
//
//  Created by Bakar Kharabadze on 7/3/24.
//

import UIKit
import SwiftUI
import Domain

// MARK: - ScheduleViewController
public final class ScheduleViewController: UIViewController {
    
    // MARK: - Properties
    private let upcomingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("UPCOMING", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(showUpcoming), for: .touchUpInside)
        return button
    }()
    
    private let pastButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PAST", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(showPast), for: .touchUpInside)
        return button
    }()
    
    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "CustomUnderline")
        return view
    }()
    
    private let containerView = UIView()
    private let upcomingTableView = UITableView()
    private let pastTableView = UITableView()
    public var viewModel: ScheduleViewModel!
    
    // MARK: - Initialization
    public class func create(with viewModel: ScheduleViewModel, raceDetailViewControllerFactory: RaceDetailViewControllerFactory) -> ScheduleViewController {
        let vc = ScheduleViewController()
        vc.viewModel = viewModel
        vc.viewModel.delegate = vc
        vc.viewModel.router = DefaultScheduleViewRouter(view: vc, raceDetailViewControllerFactory: raceDetailViewControllerFactory)
        return vc
    }
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupUI()
        viewModel.viewDidLoad()
        viewModel.delegate = self
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor(named: "CustomBackground")
        setupButtons()
        setupUnderlineView()
        setupContainerView()
        setupTableViews()
        showUpcoming()
    }
    
    private func setupButtons() {
        let stackView = UIStackView(arrangedSubviews: [upcomingButton, pastButton])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupUnderlineView() {
        view.addSubview(underlineView)
        
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            underlineView.topAnchor.constraint(equalTo: upcomingButton.bottomAnchor, constant: 5),
            underlineView.heightAnchor.constraint(equalToConstant: 2),
            underlineView.widthAnchor.constraint(equalTo: upcomingButton.widthAnchor),
            underlineView.leadingAnchor.constraint(equalTo: upcomingButton.leadingAnchor)
        ])
    }
    
    private func setupContainerView() {
        view.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: underlineView.bottomAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableViews() {
        setupTableView(upcomingTableView)
        setupTableView(pastTableView)
        
        upcomingTableView.dataSource = self
        upcomingTableView.delegate = self
        pastTableView.dataSource = self
        pastTableView.delegate = self
        
        containerView.addSubview(upcomingTableView)
        containerView.addSubview(pastTableView)
        
        upcomingTableView.translatesAutoresizingMaskIntoConstraints = false
        pastTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            upcomingTableView.topAnchor.constraint(equalTo: containerView.topAnchor),
            upcomingTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            upcomingTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            upcomingTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            pastTableView.topAnchor.constraint(equalTo: containerView.topAnchor),
            pastTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            pastTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            pastTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    private func setupTableView(_ tableView: UITableView) {
        tableView.register(UpcomingFirstRaceViewCell.self, forCellReuseIdentifier: "UpcomingFirstRaceViewCell")
        tableView.register(ScheduleViewCell.self, forCellReuseIdentifier: "ScheduleViewCell")
        tableView.register(PastFirstRaceViewCell.self, forCellReuseIdentifier: "PastFirstRaceViewCell")
        tableView.backgroundColor = UIColor(named: "CustomBackground")
        tableView.separatorStyle = .none
        tableView.isHidden = true
    }
    
    // MARK: - Actions
    @objc private func showUpcoming() {
        updateButtonColors(selectedButton: upcomingButton, deselectedButton: pastButton)
        updateUnderlinePosition(button: upcomingButton)
        
        clearContainerView()
        upcomingTableView.isHidden = false
        pastTableView.isHidden = true
        upcomingTableView.reloadData()
    }
    
    @objc private func showPast() {
        updateButtonColors(selectedButton: pastButton, deselectedButton: upcomingButton)
        updateUnderlinePosition(button: pastButton)
        
        clearContainerView()
        upcomingTableView.isHidden = true
        pastTableView.isHidden = false
        pastTableView.reloadData()
    }
    
    private func updateButtonColors(selectedButton: UIButton, deselectedButton: UIButton) {
        selectedButton.setTitleColor(.white, for: .normal)
        deselectedButton.setTitleColor(.lightGray, for: .normal)
    }
    
    private func updateUnderlinePosition(button: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.underlineView.frame.origin.x = button.frame.origin.x
            self.underlineView.frame.size.width = button.frame.size.width
        }
    }
    
    private func clearContainerView() {
        upcomingTableView.isHidden = true
        pastTableView.isHidden = true
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ScheduleViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == upcomingTableView {
            return viewModel.upcomingRaces.count + 1
        } else if tableView == pastTableView {
            return viewModel.pastRaces.count + 1
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == upcomingTableView {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingFirstRaceViewCell", for: indexPath) as! UpcomingFirstRaceViewCell
                if let firstRace = viewModel.upcomingRaces.first {
                    cell.configure(with: firstRace)
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleViewCell", for: indexPath) as! ScheduleViewCell
                let race = viewModel.upcomingRaces[indexPath.row - 1]
                let flagImageName = race.countryFlag
                cell.configure(round: race.round, title: race.grandPrixName, date: race.date, flagImage: flagImageName, isUpcoming: true)
                return cell
            }
        } else if tableView == pastTableView {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PastFirstRaceViewCell", for: indexPath) as! PastFirstRaceViewCell
                if let firstRace = viewModel.raceResults.first {
                    cell.configure(with: firstRace)
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleViewCell", for: indexPath) as! ScheduleViewCell
                let race = viewModel.pastRaces[indexPath.row - 1]
                let flagImageName = race.countryFlag
                cell.configure(round: race.round, title: race.grandPrixName, date: race.date, flagImage: flagImageName, isUpcoming: false)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            if tableView == upcomingTableView && indexPath.row > 0 {
                let race = viewModel.upcomingRaces[indexPath.row - 1]
                viewModel.raceViewTapped(race: race)
            } else if tableView == pastTableView && indexPath.row > 0 {
                let race = viewModel.pastRaces[indexPath.row - 1]
                viewModel.raceViewTapped(race: race)
            } else if tableView == upcomingTableView && indexPath.row == 0 {
                let race = viewModel.upcomingRaces[indexPath.row]
                viewModel.raceViewTapped(race: race)
            } else if tableView == pastTableView && indexPath.row == 0 {
                let race = viewModel.pastRaces[indexPath.row]
                viewModel.raceViewTapped(race: race)
            }
        }
}

// MARK: - ScheduleViewModelDelegate
extension ScheduleViewController: ScheduleViewModelDelegate {
    public func raceResultFetched(_ raceResults: [Domain.RaceResultEntity]) {
        self.pastTableView.reloadData()
    }
    
    public func racesFetched(_ races: [RaceEntity]) {
        DispatchQueue.main.async {
            self.upcomingTableView.reloadData()
            self.pastTableView.reloadData()
        }
    }
}
