// UIColor+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение доступа к цветам
extension UIColor {
    /// Словарь с названием и цветом
    static var colorStoreMap: [String: UIColor] = [:]

    /// - Parameter red, green, blue: цвета
    /// - Parameter alpha: прозрачность
    /// - Returns: готовый цвет
    class func rgba(
        _ red: CGFloat,
        _ green: CGFloat,
        _ blue: CGFloat,
        _ alfa: CGFloat
    ) -> UIColor {
        let key = "\(red) \(green) \(blue) \(alfa)"

        if let color = colorStoreMap[key] {
            return color
        }
        let color = UIColor(
            red: red,
            green: green,
            blue: blue,
            alpha: alfa
        )
        colorStoreMap[key] = color
        return color
    }

    /// Настройка черного цвета
    /// - Parameter alpha: прозрачность
    /// - Returns: готовый цвет
    class func blackColor(alpha: CGFloat) -> UIColor {
        let key = "\(alpha)"

        if let color = colorStoreMap[key] {
            return color
        }
        let color = UIColor.rgba(0 / 255, 0 / 255, 0 / 255, alpha)
        colorStoreMap[key] = color
        return color
    }

    /// Настройка цвета для иконок tabBar
    /// - Parameter alpha: прозрачность
    /// - Returns: готовый цвет
    class func selectedIconTabBarColor(alpha: CGFloat) -> UIColor {
        let key = "\(alpha)"

        if let color = colorStoreMap[key] {
            return color
        }
        let color = UIColor.rgba(114 / 255, 186 / 255, 191 / 255, alpha)
        colorStoreMap[key] = color
        return color
    }

    /// Настройка цвета заднего фона описания
    /// - Parameter alpha: прозрачность
    /// - Returns: готовый цвет
    class func backgroundDescriptionColor(alpha: CGFloat) -> UIColor {
        let key = "\(alpha)"

        if let color = colorStoreMap[key] {
            return color
        }
        let color = UIColor.rgba(222 / 255, 237 / 255, 239 / 255, alpha)
        colorStoreMap[key] = color
        return color
    }

    /// Настройка цвета заднего фона категорий
    /// - Parameter alpha: прозрачность
    /// - Returns: готовый цвет
    class func backgroundNameCategoryColor(alpha: CGFloat) -> UIColor {
        let key = "\(alpha)"

        if let color = colorStoreMap[key] {
            return color
        }
        let color = UIColor.rgba(154 / 255, 158 / 255, 161 / 255, alpha)
        colorStoreMap[key] = color
        return color
    }

    /// Настройка цвета для кнопки входа
    /// - Parameter alpha: прозрачность
    /// - Returns: готовый цвет
    class func logInButtonColor(alpha: CGFloat) -> UIColor {
        let key = "\(alpha)"

        if let color = colorStoreMap[key] {
            return color
        }
        let color = UIColor.rgba(4 / 255, 38 / 255, 40 / 255, alpha)
        colorStoreMap[key] = color
        return color
    }

    /// Настройка цвета для кнопки категорий
    /// - Parameter alpha: прозрачность
    /// - Returns: готовый цвет
    class func shadowButtonCategoryColor(alpha: CGFloat) -> UIColor {
        let key = "\(alpha)"

        if let color = colorStoreMap[key] {
            return color
        }
        let color = UIColor.rgba(4 / 255, 38 / 255, 40 / 255, alpha)
        colorStoreMap[key] = color
        return color
    }

    /// Настройка цвета для фона всплывающего окна предупреждения
    /// - Parameter alpha: прозрачность
    /// - Returns: готовый цвет
    class func splashColor(alpha: CGFloat) -> UIColor {
        let key = "\(alpha)"

        if let color = colorStoreMap[key] {
            return color
        }
        let color = UIColor.rgba(240 / 255, 97 / 255, 85 / 255, alpha)
        colorStoreMap[key] = color
        return color
    }
}
