// Proxy.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис для хранение картинок
final class Proxy: LoadServiceProtocol {
    // MARK: - Constants

    private enum Constants {
        static let pathName = "Savedimage"
    }

    // MARK: - Private Propities

    private var service: LoadServiceProtocol
    private var fileManager = FileManager.default

    init(service: LoadServiceProtocol) {
        self.service = service
    }

    func loadImage(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let imageName = url.lastPathComponent
        if let casheData = loadImage(imageName: imageName) {
            completion(casheData, nil, nil)
        } else {
            service.loadImage(url: url) { data, response, error in
                self.saveImage(imageName: imageName, image: data)
                completion(data, response, error)
            }
        }
    }

    func saveImage(imageName: String, image: Data?) {
        do {
            guard
                let folder = fileManager.urls(
                    for: .desktopDirectory,
                    in: .userDomainMask
                ).first?.appendingPathComponent(Constants.pathName)
            else {
                return
            }
            try? fileManager.createDirectory(at: folder, withIntermediateDirectories: true)
            let fileURL = folder.appendingPathComponent(imageName)
            try image?.write(to: fileURL)
        } catch {}
    }

    func loadImage(imageName: String) -> Data? {
        guard
            let url = fileManager.urls(for: .desktopDirectory, in: .userDomainMask).first?
            .appendingPathComponent(imageName)
        else {
            return nil
        }
        let data = try? Data(contentsOf: url)
        return data
    }
}
