// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для фаворитов
protocol FavoritesProtocol: AnyObject {
    /// Метод для перехода
    func pushDetailFavoritesViewController(recipe: RecipeCommonInfo)
    /// Метод для проверки пустые ли фавориты
    func emptyView()
}

/// Протокол фаворитов для вью
protocol FavoritesViewProtocol: AnyObject {
    /// Метод для проверки пустые ли фавориты
    func emptyFaforites()
    /// метод для добавления таблицы с избраннымми рецептами
    func makeTable(favorites: [RecipeCommonInfo])
}

/// Презентер для экрана с фаворитами
final class FavoritesPresenter {
    private weak var favoritesCoordinator: FavoritesCoordinator?
    private weak var view: FavoritesViewProtocol?

    init(view: FavoritesViewProtocol, favoritesCoordinator: FavoritesCoordinator) {
        self.view = view
        self.favoritesCoordinator = favoritesCoordinator
    }
}

// MARK: - Extension + FavoritesProtocol

extension FavoritesPresenter: FavoritesProtocol {
    func pushDetailFavoritesViewController(recipe: RecipeCommonInfo) {
        favoritesCoordinator?.pushRecipeDetailsViewController(recipe: recipe)
    }

    func emptyView() {
        let favoriteService = FavoritesService.shared
        if favoriteService.favorites.isEmpty {
            view?.emptyFaforites()
        } else {
            view?.makeTable(favorites: favoriteService.favorites)
        }
    }
}
