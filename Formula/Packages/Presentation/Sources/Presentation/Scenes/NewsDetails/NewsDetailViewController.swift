//
//  NewsDetailViewController.swift
//
//
//  Created by Bakar Kharabadze on 7/9/24.
//

import UIKit
import WebKit

public class NewsDetailViewController: UIViewController {

    private var mainStackView = UIStackView()
    private var titleLabel = UILabel()
    private var titleImage = UIImageView()
    private var titleDescription = UILabel()
    private var readMoreButton = UIButton(type: .system)
    
    private var viewModel: NewsDetailViewModel!
    
    public class func create(with viewModel: NewsDetailViewModel) -> NewsDetailViewController {
        let vc = NewsDetailViewController()
        vc.viewModel = viewModel
        vc.viewModel.delegate = vc
        return vc
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "CustomBackground")
        setupUI()
        viewModel.fetchImage()
    }
    
    private func setupUI() {
        setupMainStackView()
        setupTitleLabel()
        setupTitleImage()
        setupTitleDescription()
        setupCustomSpacing()
    }
    
    private func setupMainStackView() {
        view.addSubview(mainStackView)
        
        mainStackView.axis = .vertical
        mainStackView.spacing = 0
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.text = viewModel.news.title
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        mainStackView.addArrangedSubview(titleLabel)
    }
    
    private func setupTitleImage() {
        titleImage.contentMode = .scaleAspectFill
        titleImage.layer.cornerRadius = 10
        titleImage.clipsToBounds = true
        
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleImage.widthAnchor.constraint(equalToConstant: 270),
            titleImage.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        mainStackView.addArrangedSubview(titleImage)
    }
    
    private func setupTitleDescription() {
        let fullContent = viewModel.news.content
        let modifiedContent = fullContent.replacingOccurrences(of: "\\[.*?\\]", with: "", options: .regularExpression)
        
        let attributedString = NSMutableAttributedString(string: modifiedContent)
        
        let readMoreText = " Read More"
        let readMoreAttributedString = NSAttributedString(string: readMoreText, attributes: [
            .foregroundColor: UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0),
            .font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ])
        
        attributedString.append(readMoreAttributedString)
        
        titleDescription.attributedText = attributedString
        titleDescription.textColor = .white
        titleDescription.textAlignment = .left
        titleDescription.numberOfLines = 0
        titleDescription.isUserInteractionEnabled = true
        titleDescription.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(readMoreButtonTapped)))
        
        mainStackView.addArrangedSubview(titleDescription)
        
        NSLayoutConstraint.activate([
            titleDescription.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 15),
            titleDescription.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -5)
        ])
    }
    
    @objc private func readMoreButtonTapped() {
        guard let url = URL(string: viewModel.news.url) else { return }
        let webViewController = WebViewController(url: url)
        let navController = UINavigationController(rootViewController: webViewController)
        present(navController, animated: true, completion: nil)
    }
    
    private func setupCustomSpacing() {
        mainStackView.setCustomSpacing(20, after: titleLabel)
        mainStackView.setCustomSpacing(20, after: titleImage)
        mainStackView.setCustomSpacing(0, after: titleDescription)
    }
}

extension NewsDetailViewController: NewsDetailViewModelDelegate {
    public func imageFetched(_ imageData: Data?) {
        DispatchQueue.main.async {
            if let data = imageData {
                self.titleImage.image = UIImage(data: data)
            } else {
                self.titleImage.image = nil
            }
        }
    }
}

