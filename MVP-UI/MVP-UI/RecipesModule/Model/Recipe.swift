// Recipe.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Составляющая рецепта
struct Recipe: Codable, Equatable {
    /// Аватар рецепта
    var avatarRecipie: String
    /// Название рецепта
    var titleRecipies: String
    /// Время изготовления блюда
    var cookingTimeTitle: Int
    /// Калории блюда
    var caloriesTitle: Int
    /// Питательные вещества
    var nutrientsValue: [String]
    /// Описание рецепта
    var recipeDescriptionTitle: String
    /// Порция (в граммах)
    var portionWeight: String
}
