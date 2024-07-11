// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол которому доллжен соответссвовать модель юзера
protocol MementoUser: Codable, Encodable {
    /// емаил
    var emailTitle: String { get }
    /// пароль
    var passwordTitle: String { get }
    /// Логин пользователя
    var login: String { get }
    /// Аватар
    var avatar: Data? { get }
}

/// Пользователь
struct User: MementoUser {
    /// Логин пользователя
    var login: String
    /// Почта пользователя
    var emailTitle: String
    /// Пароль пользователя
    var passwordTitle: String
    /// Аватар пользователя
    var avatar: Data?
}
