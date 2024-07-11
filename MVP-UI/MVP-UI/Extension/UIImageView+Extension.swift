// UIImageView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIImageView {
    /// Расширение выполнения запроса по загрузке картинки
    /// - Parameter url: ссылка
    func downloaded(from url: URL) {
        let imageService = LoadServiceImage()
        let proxy = Proxy(service: imageService)

        proxy.loadImage(url: url) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }
    }

    /// Расширение для проверки существования картинки
    /// - Parameter link: тип ссылки
    func downloaded(from link: String) {
        guard let url = URL(string: link) else { return }
        var image: UIImage?
        if image != nil {
            self.image = image
        } else {
            downloaded(from: url)
        }
    }
}
