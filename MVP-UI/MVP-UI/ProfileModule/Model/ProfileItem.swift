// ProfileItem.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Перечисления с вариантами ячеек
enum ProfileItem {
    /// Заголовок
    case header(ProfileHeaderCellSource)
    /// Ячейки
    case navigation([ProfileNavigationCellSource])
}
