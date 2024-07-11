// ViewState.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Состояния у View в зависимости от наличия данных
enum ViewState<Model> {
    /// Загрузка данных
    case loading
    /// Данные получены
    case data(_ model: Model)
    /// Нет данных
    case noData
    /// Ошибка получения данных
    case error(_ error: Error)
}
