// UIFont+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение доступа к шрифтам
extension UIFont {
    // MARK: - Constants

    enum Constants {
        static let fontVerdana = "Verdana"
        static let fontVerdanaBold = "Verdana-Bold"
    }

    /// Настройка шрифта Verdana
    /// - Parameter size: размер шрифта
    /// - Returns: готовый шрифт
    class func verdana(size: CGFloat) -> UIFont {
        if let customFont = UIFont(name: Constants.fontVerdana, size: size) {
            return customFont
        }
        return systemFont(ofSize: size)
    }

    /// Настройка шрифта Verdana-Bold
    /// - Parameter size: размер шрифта
    /// - Returns: готовый шрифт
    class func verdanaBold(size: CGFloat) -> UIFont {
        if let customFont = UIFont(name: Constants.fontVerdanaBold, size: size) {
            return customFont
        }
        return systemFont(ofSize: size)
    }

    private func systemFont(ofSize: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: ofSize)
    }
}
