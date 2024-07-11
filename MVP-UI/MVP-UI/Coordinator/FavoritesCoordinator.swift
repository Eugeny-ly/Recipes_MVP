// FavoritesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Координатор для экрана с избарнным
final class FavoritesCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController?
    var networkService: NetworkService
    var coreDataManager: CoreDataManager

    func setRootController(viewController: UIViewController) {
        rootViewController = UINavigationController(rootViewController: viewController)
    }

    init(networkService: NetworkService, coreDataManager: CoreDataManager) {
        self.networkService = networkService
        self.coreDataManager = coreDataManager
    }

    func pushRecipeDetailsViewController(recipe: RecipeCommonInfo) {
        let recipesDetailsViewController = RecipesDetailsViewController()
        let presenter = DetailsPresenter(
            view: recipesDetailsViewController,
            recipe: recipe,
            recipesCoordinator:
            self, networkService: networkService, coreDataManager: coreDataManager
        )
        recipesDetailsViewController.detailsPresenter = presenter
        rootViewController?.pushViewController(recipesDetailsViewController, animated: true)
    }
}
