// RecipeDetailDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Детальные рецепты
struct RecipeDetailDTO: Codable {
    /// Массив для запрса
    let hits: [DetailsResponseDTO]
}
