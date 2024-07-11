// DetailDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Детальная струкрутра данных рецептов
struct DetailDTO: Codable {
    /// Заголовок
    let label: String
    /// Время приготовления
    let totalTime: Int
    /// Кол-во калорий
    let calories: Double
    /// Картинка рецепта
    let images: ImagesDTO?
    /// Масса рецепта
    let totalWeight: Double
    /// КБЖУ
    let totalNutrients: TotalNutrientsDTO
    /// Описание рецепта
    let ingredientLines: [String]
}
