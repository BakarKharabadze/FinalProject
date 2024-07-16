//
//  HomeViewController.swift
//
//
//  Created by Bakar Kharabadze on 7/3/24.
//

import UIKit
import SwiftUI
import Domain

public final class HomeViewController: UIViewController {
    
    private let mainStackView = UIStackView()
    private let logo = UIImageView()
    private let raceNameLabel = UILabel()
    private let standingLabel = UILabel()
    private let newsLabel = UILabel()
    private let scrollView = UIScrollView()
    public var viewModel: HomeViewModel!
        
    public class func create(with viewModel: HomeViewModel, newsViewControllersFactory: NewsDetailViewControllerFactory) -> HomeViewController {
        let vc = HomeViewController(viewModel: viewModel)
        vc.viewModel.router = DefaultHomeViewRouter(view: vc, newsViewControllerFactory: newsViewControllersFactory)
        return vc
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let raceViewHostingController = UIHostingController(rootView: RaceView())
    private let newsTableView = UITableView()
    
    private let driverImages = ["max", "max", "max"]
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "CustomBackground")
        setupUI()
        viewModel.delegate = self
        viewModel.viewDidLoad()
        newsTableView.delegate = self
    }
    
    private func setupUI() {
        setupScrollView()
        setupMainStackView()
        setupLogo()
        setupRaceNameLabel()
        setupRaceView()
        setupStandingLabel()
        setupCustomSpacing()
        setupNewsTableView()
        setupNewsLabel()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupMainStackView() {
        view.addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.alignment = .leading
        mainStackView.distribution = .fill
        mainStackView.spacing = 10
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupCustomSpacing() {
        mainStackView.setCustomSpacing(20, after: raceViewHostingController.view)
    }
    
    private func setupLogo() {
        logo.image = UIImage(named: "Formula1Logo")
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.widthAnchor.constraint(equalToConstant: 20).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        logo.contentMode = .scaleAspectFit
        
        mainStackView.addArrangedSubview(logo)
        
        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupRaceNameLabel() {
        raceNameLabel.text = "Race"
        raceNameLabel.font = .systemFont(ofSize: 18)
        raceNameLabel.textAlignment = .left
        raceNameLabel.textColor = .white
        
        mainStackView.addArrangedSubview(raceNameLabel)
    }
    
    private func setupRaceView() {
        addChild(raceViewHostingController)
        raceViewHostingController.view.backgroundColor = .clear
        mainStackView.addArrangedSubview(raceViewHostingController.view)
        raceViewHostingController.didMove(toParent: self)
        
        raceViewHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            raceViewHostingController.view.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleRaceViewTap))
        raceViewHostingController.view.addGestureRecognizer(tapGesture)
        raceViewHostingController.view.isUserInteractionEnabled = true
    }
    
    @objc private func handleRaceViewTap() {
        //        let raceDetailVC = RaceDetailViewController()
        //        raceDetailVC.modalPresentationStyle = .automatic
        //        present(raceDetailVC, animated: true, completion: nil)
    }
    
    private func setupStandingLabel() {
        standingLabel.text = "Standing"
        standingLabel.font = .systemFont(ofSize: 18)
        standingLabel.textAlignment = .left
        standingLabel.textColor = .white
        
        mainStackView.addArrangedSubview(standingLabel)
    }
    
    private func setupTopDriversView(with drivers: [DriverEntity]) {
        let topDriversHostingController = UIHostingController(rootView: TopDriversCoverFlowView(drivers: drivers))
        topDriversHostingController.view.backgroundColor = .clear
        addChild(topDriversHostingController)
        mainStackView.insertArrangedSubview(topDriversHostingController.view, at: 4)
        topDriversHostingController.didMove(toParent: self)
        
        topDriversHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topDriversHostingController.view.heightAnchor.constraint(equalToConstant: 150),
            topDriversHostingController.view.widthAnchor.constraint(equalTo: mainStackView.widthAnchor)
        ])
    }
    
    private func setupNewsLabel() {
        newsLabel.text = "News"
        newsLabel.font = .systemFont(ofSize: 18)
        newsLabel.textAlignment = .left
        newsLabel.textColor = .white
        
        mainStackView.addArrangedSubview(newsLabel)
    }
    
    private func setupNewsTableView() {
        newsTableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        newsTableView.dataSource = self
        newsTableView.rowHeight = 220
        newsTableView.separatorStyle = .none
        
        view.addSubview(newsTableView)
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 5),
            newsTableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            newsTableView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            newsTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
    
}

extension HomeViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNews = viewModel.news[indexPath.row]
        viewModel.newsViewTapped(news: selectedNews)
    }
}

extension HomeViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.news.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }
        let newsEntity = viewModel.news[indexPath.row]
        cell.configure(with: newsEntity)
        return cell
    }
}

extension HomeViewController: HomeViewModelDelegate {
    public func newsFetched(_ news: [Domain.NewsEntity]) {
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }
    
    public func driversFetched(_ drivers: [DriverEntity]) {
        DispatchQueue.main.async {
            self.setupTopDriversView(with: drivers)
        }
    }
}
