// TotalDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// КБЖУ для детального рецепта
struct TotalNutrientsDTO: Codable {
    /// Калории
    let calories: TotalDTO
    /// Жиры
    let fat: TotalDTO
    /// Белки
    let protein: TotalDTO
    /// Углеводы
    let chocdf: TotalDTO

    /// Названия ключей
    enum CodingKeys: String, CodingKey {
        /// Ключ calories
        case calories = "ENERC_KCAL"
        /// Ключ fat
        case fat = "CHOCDF"
        /// Ключ protein
        case protein = "FAT"
        /// Ключ chocdf
        case chocdf = "PROCNT"
    }
}

/// Структура представляющая кол-во КБЖУ
struct TotalDTO: Codable {
    /// Количество КБЖУ
    let quantity: Double
}
