// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import Swinject
import UIKit

/// Главный координатор
final class ApplicationCoordinator: BaseCoordinator {
    enum SelectedDipLink {
        case favorites
        case userProfile
        case main
    }

    private var tabBarViewController = TabBarController()
    private let userCoordinator = UserProfileCoordinator()

    private var appBuilder: AppBulder
    private var conteiner: Container
    override func start() {
        tabBarMain()
    }

    func dipLinkSelected(selected: SelectedDipLink, itemBonus: String? = nil) {
        switch selected {
        case .favorites:
            tabBarViewController.selectedIndex = 1
        case .userProfile:
            tabBarViewController.selectedIndex = 2
        case .main:
            email(email: itemBonus)
        }
    }

    private func email(email: String?) {
        toAutorization(email: email)
    }

    init(appBuilder: AppBulder, conteiner: Container) {
        self.appBuilder = appBuilder
        self.conteiner = conteiner
    }

    private func tabBarMain() {
        if let networkSrvice = conteiner.resolve(NetworkService.self),
           let coreDataManager = conteiner.resolve(CoreDataManager.self)
        {
            let recipesCoordinator = RecipesCoordinator(networkService: networkSrvice, coreDataManager: coreDataManager)
            let recipesModule = appBuilder.makeRecipesViewController(recipecCoordinator: recipesCoordinator)
            recipesCoordinator.setRootController(viewController: recipesModule)
            add(coordinator: recipesCoordinator)

            let favoriteCoordinator = FavoritesCoordinator(
                networkService: networkSrvice,
                coreDataManager: coreDataManager
            )
            let favoritesModule = appBuilder.makeFavoritesViewController(favoritesCoordinator: favoriteCoordinator)
            favoriteCoordinator.setRootController(viewController: favoritesModule)
            add(coordinator: favoriteCoordinator)

            let userProfileModule = appBuilder
                .makeUserProfileViewController(userProfileUserCoordinator: userCoordinator)
            userCoordinator.setRootController(viewController: userProfileModule)
            add(coordinator: userCoordinator)

            guard let recipesRootViewController = recipesCoordinator.rootViewController else { return }
            guard let favoriteViewController = favoriteCoordinator.rootViewController else { return }
            guard let userViewController = userCoordinator.rootViewController else { return }

            tabBarViewController.setViewControllers(
                [
                    recipesRootViewController,
                    favoriteViewController,
                    userViewController
                ],
                animated: false
            )
            let tabBarViewController = tabBarViewController

            setAsRoot​(​_​: tabBarViewController)
        }
    }

    private func toAutorization(email: String? = nil) {
        var autorizationCoordinator = AutorizationCoordinator()
        autorizationCoordinator.setEmailDiplink(email: email)
        autorizationCoordinator.onFinishFlow = { [weak self] in
            self?.remove(coordinator: autorizationCoordinator)
            self?.tabBarMain()
        }
        add(coordinator: autorizationCoordinator)
        autorizationCoordinator.start()
    }
}
