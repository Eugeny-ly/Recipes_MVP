// FavoritesService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис для работы с фаворитам
final class FavoritesService {
    // MARK: - Constants

    private enum Constants {
        static let favoriteKey = "FavoriteKey"
    }

    public enum Error: Swift.Error {
        case favoritesNo
    }

    static let shared = FavoritesService()

    var favorites: [RecipeCommonInfo] = []

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private init() {
        loadFavorites()
    }

    func saveFavorites() {
        do {
            let userData: Memento = try encoder.encode(favorites)
            UserDefaults.standard.set(userData, forKey: Constants.favoriteKey)
        } catch {}
    }

    func loadFavorites() {
        do {
            guard let userData = UserDefaults.standard.value(forKey: Constants.favoriteKey) as? Memento,
                  let fovorites = try? decoder.decode([RecipeCommonInfo].self, from: userData)
            else { throw Error.favoritesNo }
            favorites = fovorites
        } catch {}
    }
}
