// UIView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIView {
    /// Расширение для поворота вью вокруг себя
    func rotate() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        layer.add(rotation, forKey: "rotationAnimation")
    }
}
