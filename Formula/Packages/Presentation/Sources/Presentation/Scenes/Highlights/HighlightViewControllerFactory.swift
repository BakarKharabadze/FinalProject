//
//  HighlightViewControllerFactory.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import UIKit

public protocol HighlightViewControllerFactory {
    func makeHighlightViewController() -> HighlightsViewController
}
