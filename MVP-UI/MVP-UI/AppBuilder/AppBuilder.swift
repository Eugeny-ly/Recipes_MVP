// AppBuilder.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import Swinject
import UIKit

/// Контейнер для проставления зависимостей и сборки модуля
final class AppBulder {
    // MARK: - Private Properties

    private var serviceContainer: Container

    // MARK: - Initializers

    init(serviceDistributor: Container) {
        serviceContainer = serviceDistributor
    }

    func makeRecipesViewController(recipecCoordinator: RecipesCoordinator) -> RecipesViewController {
        let view = RecipesViewController()
        let presenter = RecipesPresenter(view: view, coordinator: recipecCoordinator)
        view.presenter = presenter
        view.tabBarItem = UITabBarItem(
            title: "Recipes",
            image: UIImage.recipes,
            selectedImage: UIImage.recipesFill
        )
        return view
    }

    func makeFavoritesViewController(favoritesCoordinator: FavoritesCoordinator) -> FavoritesViewController {
        let favoritesViewController = FavoritesViewController()
        let favoritesPresenter = FavoritesPresenter(
            view: favoritesViewController,
            favoritesCoordinator: favoritesCoordinator
        )
        favoritesViewController.favoritesPresenter = favoritesPresenter
        favoritesViewController.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage.favorites,
            selectedImage: UIImage.favoritesFill
        )
        return favoritesViewController
    }

    func makeUserProfileViewController(
        userProfileUserCoordinator: UserProfileCoordinator
    ) -> UserProfileViewController {
        let view = UserProfileViewController()
        let presenter = UserProfilePresenter(view: view, userCoordinator: userProfileUserCoordinator)
        view.presenter = presenter
        view.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage.smile,
            selectedImage: UIImage.smileFill
        )
        return view
    }

    func makeConteiner() {
        serviceContainer.register(NetworkService.self) { _ in
            NetworkService()
        }
        serviceContainer.register(CoreDataManager.self) { _ in
            CoreDataManager()
        }
    }
}
