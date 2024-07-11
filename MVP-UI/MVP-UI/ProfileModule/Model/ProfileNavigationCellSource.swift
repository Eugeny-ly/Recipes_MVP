// ProfileNavigationCellSource.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Источник данных ячеек навигации
struct ProfileNavigationCellSource {
    /// Иконка ячейки
    let shortcutCell: String
    /// Название ячейки
    let nameCell: String

    // MARK: - Public Methods

    static func getProfileNavigation() -> [ProfileNavigationCellSource] {
        let profileFields: [ProfileNavigationCellSource] = [
            .init(shortcutCell: "bonuses", nameCell: "Bonuses"),
            .init(shortcutCell: "termsPrivacyPolicy", nameCell: "Terms & Privacy Policy"),
            .init(shortcutCell: "Our Partners", nameCell: "Our Partners"),
            .init(shortcutCell: "logOut", nameCell: "Log out")
        ]
        return profileFields
    }
}
