// RecipeResponseDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// РецептDTO
struct RecipeResponseDTO: Codable {
    /// Массив рецептов
    let hits: [RecipeHitDTO]
}
