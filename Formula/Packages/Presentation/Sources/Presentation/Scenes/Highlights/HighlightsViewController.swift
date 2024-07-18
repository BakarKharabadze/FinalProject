//
//  HighlightsViewController.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import UIKit
import WebKit
import Domain

public final class HighlightsViewController: UIViewController {
    
    private let mainStackView = UIStackView()
    private let logoImageView = UIImageView()
    private let highlightsTableView = UITableView()
    
    public var viewModel: HighlightsViewModel!
    
    public class func create(with viewModel: HighlightsViewModel) -> HighlightsViewController {
        let vc = HighlightsViewController(viewModel: viewModel)
        vc.viewModel = viewModel
        return vc
    }

    init(viewModel: HighlightsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "CustomBackground")
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupUI()
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
    private func setupUI() {
        setupMainStackView()
        setupLogoImageView()
        setupHighlightsTableView()
    }
    
    private func setupMainStackView() {
        view.addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.alignment = .leading
        mainStackView.distribution = .fill
        mainStackView.spacing = 10
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20), // შეცვლილი
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupLogoImageView() {
        logoImageView.image = UIImage(named: "Youtube", in: Bundle.module, with: nil)
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView.addArrangedSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor)
        ])
    }
    
    private func setupHighlightsTableView() {
        highlightsTableView.register(HighlightsTableViewCell.self, forCellReuseIdentifier: "HighlightsTableViewCell")
        highlightsTableView.dataSource = self
        highlightsTableView.delegate = self
        highlightsTableView.rowHeight = 340
        highlightsTableView.separatorStyle = .none
        highlightsTableView.backgroundColor = UIColor(named: "CustomBackground")
        
        view.addSubview(highlightsTableView)
        highlightsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            highlightsTableView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 5),
            highlightsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            highlightsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            highlightsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
    private func openVideoOnYouTube(videoId: String) {
        let videoURLString = "https://www.youtube.com/watch?v=\(videoId)"
        guard let videoURL = URL(string: videoURLString) else { return }
        
        let webViewController = WebViewController(url: videoURL)
        let navController = UINavigationController(rootViewController: webViewController)
        present(navController, animated: true, completion: nil)
    }
}

extension HighlightsViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.videos.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HighlightsTableViewCell", for: indexPath) as? HighlightsTableViewCell else {
            return UITableViewCell()
        }
        let highlight = viewModel.videos[indexPath.row]
        cell.configure(with: highlight)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let highlight = viewModel.videos[indexPath.row]
        openVideoOnYouTube(videoId: highlight.fetchedVideosId)
    }
}

extension HighlightsViewController: HighlightsViewModelDelegate {
    public func videosFetched(_ videos: [VideosEntity]) {
        DispatchQueue.main.async {
            self.highlightsTableView.reloadData()
        }
    }
}
