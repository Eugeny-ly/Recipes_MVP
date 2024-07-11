// TabBarController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Таб бар контроллер
final class TabBarController: UITabBarController {
    // MARK: - Constants

    private enum Constants {
        static let tabBarTintColor = UIColor(named: "selectedIconTabBar")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBar.tintColor = Constants.tabBarTintColor
    }
}
