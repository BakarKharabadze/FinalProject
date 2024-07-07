//
//  DriversViewController.swift
//
//
//  Created by Bakar Kharabadze on 7/5/24.
//

import UIKit

class DriversViewController: UIViewController {
    
    private let tableView = UITableView()
    private var drivers: [Driver] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        drivers = [
            Driver(ranking: "01", name: "Max Verstappen", team: "Red Bull", points: 51, imageName: "Max"),
            Driver(ranking: "02", name: "Sergio Perez", team: "Red Bull", points: 36, imageName: "Max"),
            Driver(ranking: "03", name: "Charles Leclerc", team: "Ferrari", points: 28, imageName: "Max"),
            Driver(ranking: "04", name: "George Russell", team: "Mercedes", points: 18, imageName: "Max"),
            Driver(ranking: "05", name: "Oscar Piastri", team: "McLaren", points: 16, imageName: "Max")
        ]
    }
    
    private func setupTableView() {
        tableView.register(DriversTableViewCell.self, forCellReuseIdentifier: "DriversTableViewCell")
        
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.reloadData()
    }
    
}

extension DriversViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        drivers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DriversTableViewCell", for: indexPath) as! DriversTableViewCell
        let driver = drivers[indexPath.row]
        cell.configure(with: driver)
        return cell
    }
}

