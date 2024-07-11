// UIStackView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для работы со StackView
extension UIStackView {
    convenience init(arrangedsSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedsSubviews)
        self.axis = axis
        self.spacing = spacing
        translatesAutoresizingMaskIntoConstraints = false
    }
}
