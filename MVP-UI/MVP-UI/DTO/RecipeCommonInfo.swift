// RecipeCommonInfo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Краткая информация о рецепте
final class RecipeCommonInfo: Codable, Equatable {
    static func == (lhs: RecipeCommonInfo, rhs: RecipeCommonInfo) -> Bool {
        true
    }

    /// Картинка
    let image: String
    /// Заголловок
    let label: String
    /// Время приготовллениия
    let totaltime: Double
    /// Калории
    let calories: Int
    /// URI
    let uri: String

    init(dto: RecipeDTO) {
        image = dto.image
        label = dto.label
        totaltime = dto.totalTime
        calories = Int(dto.calories)
        uri = dto.uri
    }
}
