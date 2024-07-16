//
//  NewsDetailViewControllerFactory.swift
//
//
//  Created by Bakar Kharabadze on 7/9/24.
//

import UIKit

public protocol NewsDetailViewControllerFactory {
    func makeNewsDetailViewController(with viewModel: NewsDetailViewModel) -> NewsDetailViewController
}
