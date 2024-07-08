//
//  ScheduleViewController.swift
//
//
//  Created by Bakar Kharabadze on 7/3/24.
//

import UIKit

class ScheduleViewController: UIViewController {
    
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
        view.backgroundColor = .red
        return view
    }()
    
    private let containerView = UIView()
    
    private let upcomingTableView = UITableView()
    private let pastTableView = UITableView()
    
    private let upcomingData = [
        ("Upcoming Race 1", "Subtitle 1", "Detail 1", UIImage(named: "imageName")),
        ("Upcoming Race 2", "Subtitle 2", "Detail 2", UIImage(named: "imageName")),
        ("Upcoming Race 3", "Subtitle 3", "Detail 3", UIImage(named: "imageName"))
    ]
    
    private let pastData = [
        ("Past Race A", "Subtitle A", "Detail A", UIImage(named: "yourImageName")),
        ("Past Race B", "Subtitle B", "Detail B", UIImage(named: "yourImageName")),
        ("Past Race C", "Subtitle C", "Detail C", UIImage(named: "yourImageName"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
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
        pastTableView.dataSource = self
        
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
        tableView.isHidden = true
    }
    
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

extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == upcomingTableView {
            return upcomingData.count + 1
        } else if tableView == pastTableView {
            return pastData.count + 1 
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == upcomingTableView {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingFirstRaceViewCell", for: indexPath) as! UpcomingFirstRaceViewCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleViewCell", for: indexPath) as! ScheduleViewCell
                let data = upcomingData[indexPath.row - 1]
                cell.configure(round: data.0, title: data.1, date: data.2, flagImage: data.3)
                return cell
            }
        } else if tableView == pastTableView {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PastFirstRaceViewCell", for: indexPath) as! PastFirstRaceViewCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleViewCell", for: indexPath) as! ScheduleViewCell
                let data = pastData[indexPath.row - 1]
                cell.configure(round: data.0, title: data.1, date: data.2, flagImage: data.3)
                return cell
            }
        }
        return UITableViewCell()
    }
}
    
