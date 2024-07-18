//
//  DriversViewController.swift
//
//
//  Created by Bakar Kharabadze on 7/5/24.
//

import UIKit
import Domain

public final class DriversViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private var viewModel: DriversViewModel!
    
    public class func create(with viewModel: DriversViewModel) -> DriversViewController {
        let vc = DriversViewController()
        vc.viewModel = viewModel
        vc.viewModel.router = vc  // Assign router to the view controller
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "CustomBackground")
        navigationController?.navigationBar.barTintColor = UIColor(named: "CustomBackground")
        setupUI()
    }
    
    private func setupUI() {
        setupTableView()
        setupTitleLabel()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self  // Set delegate to self
        tableView.backgroundColor = UIColor(named: "CustomBackground")
        tableView.register(DriversTableViewCell.self, forCellReuseIdentifier: "DriversTableViewCell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTitleLabel() {
        title = "Drivers"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension DriversViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.drivers.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DriversTableViewCell", for: indexPath) as! DriversTableViewCell
        let driver = viewModel.drivers[indexPath.row]
        cell.configure(with: driver, viewModel: viewModel)
        return cell
    }
}

extension DriversViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let driver = viewModel.drivers[indexPath.row]
        viewModel.driverViewTapped(driver: driver)
    }
}

extension DriversViewController: DriversViewRouter {
    public func perform(to route: DriversViewRoute) {
        switch route {
        case .showDriverDetails(let viewModel):
            let driverDetailsVC = DriverDetailsViewController.create(with: viewModel)
            navigationController?.pushViewController(driverDetailsVC, animated: true)
        }
    }
}

extension DriversViewController: StandingViewModelDelegate {
    public func teamsFetched(_ teams: [TeamsEntity]) {
        
    }
    
    public func driversFetched(_ drivers: [DriverEntity]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
