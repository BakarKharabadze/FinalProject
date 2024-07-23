//
//  DefaultHomeViewRouter.swift
//
//
//  Created by Bakar Kharabadze on 7/9/24.
//

import UIKit

// MARK: - DefaultHomeViewRouter

final class DefaultHomeViewRouter: HomeViewRouter {
    
    // MARK: - Properties
    weak var view: HomeViewController?
    private let newsViewControllerFactory: NewsDetailViewControllerFactory
    
    // MARK: - Initializers
    init(view: HomeViewController,
         newsViewControllerFactory: NewsDetailViewControllerFactory) {
        self.view = view
        self.newsViewControllerFactory = newsViewControllerFactory
    }
    
    // MARK: - HomeViewRouter Methods
    func perform(to route: HomeViewRoute) {
        switch route {
        case .showNewsDetail:
            guard let selectedNews = view?.viewModel.selectedNews else { return }
            let newsDetailViewModel = NewsDetailViewModel(news: selectedNews)
            let vc = newsViewControllerFactory.makeNewsDetailViewController(with: newsDetailViewModel)
            view?.navigationController?.pushViewController(vc, animated: false)
        }
    }
}
