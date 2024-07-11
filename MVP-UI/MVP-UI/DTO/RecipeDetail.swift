// RecipeDetail.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Детальная информация о рецепте
final class RecipeDetail {
    /// Заголовок
    let label: String
    /// Время приготовления
    let totalTime: Int
    /// Кол-во калорий
    let calories: Int
    /// Картинка рецепта
    let images: String
    /// Масса рецепта
    let totalWeight: Int
    /// КБЖУ
    let totalNutrients: TotalNutrientsDTO
    /// Описание рецепта
    let ingridientLines: [String]

    init(dto: DetailDTO) {
        label = dto.label
        totalTime = dto.totalTime
        calories = Int(dto.calories)
        images = dto.images?.regular.url ?? ""
        totalWeight = Int(dto.totalWeight)
        totalNutrients = dto.totalNutrients
        ingridientLines = dto.ingredientLines
    }
}
