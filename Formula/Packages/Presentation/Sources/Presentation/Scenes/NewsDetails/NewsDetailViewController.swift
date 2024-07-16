//
//  NewsDetailViewController.swift
//  
//
//  Created by Bakar Kharabadze on 7/9/24.
//

import UIKit

public class NewsDetailViewController: UIViewController {

    private var mainStackView = UIStackView()
    private var titleLabel = UILabel()
    private var titleImage = UIImageView()
    private var titleDescription = UILabel()
    
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
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.text = viewModel.news.title
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        mainStackView.addArrangedSubview(titleLabel)
    }
    
    private func setupTitleImage() {
        titleImage.contentMode = .scaleAspectFill
        titleImage.layer.cornerRadius = 10
        
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleImage.widthAnchor.constraint(equalToConstant: 250),
            titleImage.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        mainStackView.addArrangedSubview(titleImage)
    }
    
    private func setupTitleDescription() {
        titleDescription.text = viewModel.news.content
        titleDescription.textColor = .white
        titleDescription.textAlignment = .left
        titleDescription.numberOfLines = 0
        
        mainStackView.addArrangedSubview(titleDescription)
    }
    
    private func setupCustomSpacing() {
        mainStackView.setCustomSpacing(20, after: titleLabel)
        mainStackView.setCustomSpacing(20, after: titleImage)
        mainStackView.setCustomSpacing(20, after: titleDescription)
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
