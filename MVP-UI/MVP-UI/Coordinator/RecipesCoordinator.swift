// RecipesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Координатор для экрана с рецептами
final class RecipesCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController?
    var networkService: NetworkService
    var coreDataManager: CoreDataManager

    init(networkService: NetworkService, coreDataManager: CoreDataManager) {
        self.networkService = networkService
        self.coreDataManager = coreDataManager
    }

    func setRootController(viewController: UIViewController) {
        rootViewController = UINavigationController(rootViewController: viewController)
    }

    func pushDetailViewController(category: Category) {
        let recipiesViewController = RecipesListViewController()
        let presenter = RecipePresenter(
            view: recipiesViewController,
            category: category,
            detailsRecipeCoordinator: self, networkService: networkService, coreDataManager: coreDataManager
        )
        recipiesViewController.recipePresenter = presenter
        rootViewController?.pushViewController(recipiesViewController, animated: true)
        recipiesViewController.tabBarController?.tabBar.isHidden = true
        recipiesViewController.navigationController?.navigationBar.prefersLargeTitles = false
    }

    func pushRecipeDetailsViewController(recipe: RecipeCommonInfo) {
        let recipesDetailsViewController = RecipesDetailsViewController()
        let presenter = DetailsPresenter(
            view: recipesDetailsViewController,
            recipe: recipe,
            recipesCoordinator: self,
            networkService: networkService, coreDataManager: coreDataManager
        )
        recipesDetailsViewController.detailsPresenter = presenter
        rootViewController?.pushViewController(recipesDetailsViewController, animated: true)
    }
}
