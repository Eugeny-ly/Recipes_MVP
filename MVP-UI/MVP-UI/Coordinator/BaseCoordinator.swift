// BaseCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Базовый координатор
class BaseCoordinator {
    var childCoordinator: [BaseCoordinator] = []

    func start() {
        fatalError("child должен быть реализован")
    }

    func add(coordinator: BaseCoordinator) {
        childCoordinator.append(coordinator)
    }

    func remove(coordinator: BaseCoordinator) {
        childCoordinator = childCoordinator.filter { $0 !== coordinator }
    }

    func setAsRoot​(​_​ controller: UIViewController) {
        let window = UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .last { $0.isKeyWindow }
        window?.rootViewController = controller
    }
}
