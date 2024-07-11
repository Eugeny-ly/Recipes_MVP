// LoadServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для  кеширование картинок

protocol LoadServiceProtocol {
    /// Cохранение картинок
    /// - Parameter url: ссылка на картинку
    /// - Parameter completion: параметры запроса
    /// - Returns: Void
    func loadImage(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
}
