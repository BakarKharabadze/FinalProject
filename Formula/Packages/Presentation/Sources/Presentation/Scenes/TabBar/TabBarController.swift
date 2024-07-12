//
//  TabBarController.swift
//
//
//  Created by Bakar Kharabadze on 7/3/24.
//

import UIKit

final public class TabBarController: UITabBarController {
    
    var homeSceneViewControllerFactory: HomeViewControllerFactory
    var scheduleSceneViewControllerFactory: ScheduleViewControllerFactory
    var standingSceneViewControllerFactory: StandingViewControllerFactory
    var highlightSceneViewControllerFactory: HighlightViewControllerFactory
    
    public init(homeSceneViewControllerFactory: HomeViewControllerFactory, scheduleSceneViewControllerFactory: ScheduleViewControllerFactory, standingSceneViewControllerFactory: StandingViewControllerFactory, highlightSceneViewControllerFactory: HighlightViewControllerFactory) {
        self.homeSceneViewControllerFactory = homeSceneViewControllerFactory
        self.scheduleSceneViewControllerFactory = scheduleSceneViewControllerFactory
        self.standingSceneViewControllerFactory = standingSceneViewControllerFactory
        self.highlightSceneViewControllerFactory = highlightSceneViewControllerFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTabs()
        setupTabBarAppearance()
    }
    
    private func setupTabs() {
        let home = createNav(with: "Home", and: UIImage(systemName: "house") ?? UIImage(), vc: homeSceneViewControllerFactory.makeHomeViewController())
        let schedule = createNav(with: "Schedule", and: UIImage(systemName: "calendar") ?? UIImage(), vc: scheduleSceneViewControllerFactory.makeScheduleViewController())
        let standing = createNav(with: "Standing", and: UIImage(systemName: "chart.bar") ?? UIImage(), vc: standingSceneViewControllerFactory.makeStandingViewController())
        let highlights = createNav(with: "Highlights", and: UIImage(systemName: "star.fill") ?? UIImage(), vc: highlightSceneViewControllerFactory.makeHighlightViewController())
        
        setViewControllers([home, schedule, standing, highlights], animated: false)
    }
    
    private func createNav(with title: String, and image: UIImage, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        return nav
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(white: 0.1, alpha: 1.0) 
        
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = UIColor.lightGray
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
        itemAppearance.selected.iconColor = UIColor.white
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}



