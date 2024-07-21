//
//  TabBarViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/19/24.
//

import UIKit

public final class TabBarViewModel {
    
    // MARK: - Properties
    private var homeSceneViewControllerFactory: HomeViewControllerFactory
    private var scheduleSceneViewControllerFactory: ScheduleViewControllerFactory
    private var standingSceneViewControllerFactory: StandingViewControllerFactory
    private var highlightSceneViewControllerFactory: HighlightViewControllerFactory
    
    // MARK: - Initialization
    public init(homeSceneViewControllerFactory: HomeViewControllerFactory, scheduleSceneViewControllerFactory: ScheduleViewControllerFactory, standingSceneViewControllerFactory: StandingViewControllerFactory, highlightSceneViewControllerFactory: HighlightViewControllerFactory) {
        self.homeSceneViewControllerFactory = homeSceneViewControllerFactory
        self.scheduleSceneViewControllerFactory = scheduleSceneViewControllerFactory
        self.standingSceneViewControllerFactory = standingSceneViewControllerFactory
        self.highlightSceneViewControllerFactory = highlightSceneViewControllerFactory
    }
    
    // MARK: - Methods
    func createTabs() -> [UINavigationController] {
        let home = createNav(with: "Home", and: UIImage(systemName: "house") ?? UIImage(), vc: homeSceneViewControllerFactory.makeHomeViewController())
        let schedule = createNav(with: "Schedule", and: UIImage(systemName: "calendar") ?? UIImage(), vc: scheduleSceneViewControllerFactory.makeScheduleViewController())
        let standing = createNav(with: "Standing", and: UIImage(systemName: "chart.bar") ?? UIImage(), vc: standingSceneViewControllerFactory.makeStandingViewController())
        let highlights = createNav(with: "Highlights", and: resizeImage(image: UIImage(named: "YoutubeLogo") ?? UIImage(), targetSize: CGSize(width: 30, height: 30)), vc: highlightSceneViewControllerFactory.makeHighlightViewController())
        
        return [home, schedule, standing, highlights]
    }
    
    private func createNav(with title: String, and image: UIImage, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
    
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        let rect = CGRect(origin: .zero, size: newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

