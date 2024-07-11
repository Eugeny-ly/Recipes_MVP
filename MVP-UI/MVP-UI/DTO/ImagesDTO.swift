// ImagesDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура данных картинок
struct ImagesDTO: Codable {
    /// размер картинки
    let thumbnail, small, regular: ComponentsImageDTO
    /// Ссылка на картинку
    let large: ComponentsImageDTO?

    enum CodingKeys: String, CodingKey {
        case thumbnail = "THUMBNAIL"
        case small = "SMALL"
        case regular = "REGULAR"
        case large = "LARGE"
    }
}
