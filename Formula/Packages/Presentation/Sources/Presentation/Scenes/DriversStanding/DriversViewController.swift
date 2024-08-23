//
//  DriversViewController.swift
//
//
//  Created by Bakar Kharabadze on 7/5/24.
//

import UIKit
import Domain

public final class DriversViewController: UIViewController {
    
    // MARK: - Properties
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var viewModel: DriversViewModel!
    private let errorMessageLabel = UILabel()
    
    // MARK: - Initialization
    public class func create(with viewModel: DriversViewModel, driverDetailsVIewControllerFactory: DriverDetailsViewControllerFactory) -> DriversViewController {
        let vc = DriversViewController()
        vc.viewModel = viewModel
        vc.viewModel.router = DefaultDriversViewRouter(view: vc, driverDetailsVIewControllerFactory: driverDetailsVIewControllerFactory)
        vc.viewModel.delegate = vc
        return vc
    }
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "CustomBackground")
        navigationController?.navigationBar.barTintColor = UIColor(named: "CustomBackground")
        setupUI()
        viewModel.fetchDrivers()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        setupTableView()
        setupTitleLabel()
        setupActivityIndicator()
        setupErrorMessageLabel()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
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
        let font = UIFont.boldSystemFont(ofSize: 20)
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: font
        ]
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
        errorMessageLabel.textColor = .white
        errorMessageLabel.font = .systemFont(ofSize: 22, weight: .bold)
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.textAlignment = .center
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
    
    // MARK: - Loader Functions
    private func showLoader() {
        activityIndicator.startAnimating()
        tableView.isHidden = true
        errorMessageLabel.isHidden = true
    }
    
    private func hideLoader() {
        activityIndicator.stopAnimating()
        tableView.isHidden = false
    }
    
    public func showErrorText(message: String) {
        errorMessageLabel.text = message
        errorMessageLabel.isHidden = false
        tableView.isHidden = true
        activityIndicator.stopAnimating()
    }
}

// MARK: - UITableViewDataSource
extension DriversViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.drivers.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DriversTableViewCell", for: indexPath) as! DriversTableViewCell
        let driver = viewModel.drivers[indexPath.row]
        cell.configure(with: driver, viewModel: viewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DriversViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let driver = viewModel.drivers[indexPath.row]
        viewModel.driverViewTapped(driver: driver)
    }
}

// MARK: - DriversViewModelDelegate
extension DriversViewController: DriversViewModelDelegate {
    
    public func driversFetched(_ drivers: [DriverEntity]) {
        DispatchQueue.main.async {
            self.hideLoader()
            self.tableView.reloadData()
        }
    }
    
    public func showLoading() {
        showLoader()
    }
    
    public func hideLoading() {
        hideLoader()
    }
    
    public func showError(message: String) {
        showErrorText(message: message)
    }
}
