// ProfileHeaderCellSource.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Источник данных ячейки шапки профиля
struct ProfileHeaderCellSource {
    /// Аватарка пользователя
    let avatarImageName: Data?
    /// Имя пользователя
    var userName: String

    // MARK: - Public Methods

    static func getProfileHeader() -> ProfileHeaderCellSource {
        let userServis = UserSevice.shared
        return ProfileHeaderCellSource(
            avatarImageName: userServis.userAvatar,
            userName: userServis.user?.login ?? "Untilted"
        )
    }
}
