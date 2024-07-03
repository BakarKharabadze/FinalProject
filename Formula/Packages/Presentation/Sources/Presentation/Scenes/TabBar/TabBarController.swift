//
//  TabBarController.swift
//  
//
//  Created by Bakar Kharabadze on 7/3/24.
//

import UIKit

final public class TabBarController: UITabBarController {

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTabs()

    }
    
    private func setupTabs() {
        let home = createNav(with: "Home", and: UIImage(systemName: "house") ?? UIImage(), vc: HomeViewController())
        let schedule = createNav(with: "Schedule", and: UIImage(systemName: "calendar") ?? UIImage(), vc: ScheduleViewController())
        let standing = createNav(with: "Standing", and: UIImage(systemName: "chart.bar") ?? UIImage(), vc: StandingViewController())
        let highlights = createNav(with: "Highlights", and: UIImage(systemName: "star.fill") ?? UIImage(), vc: HighlightsViewController())
        
        setViewControllers([home, schedule, standing, highlights], animated: false)
    }

    private func createNav(with title: String, and image: UIImage, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        return nav
    }

}

