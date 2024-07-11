// LoadServiceImage.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Cервис для загрузки картинки
final class LoadServiceImage: LoadServiceProtocol {
    func loadImage(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let configure = URLSessionConfiguration.default
        configure.requestCachePolicy = .reloadIgnoringLocalCacheData
        configure.urlCache = nil

        let session = URLSession(configuration: configure)
        session.dataTask(with: url, completionHandler: completion).resume()
    }
}
