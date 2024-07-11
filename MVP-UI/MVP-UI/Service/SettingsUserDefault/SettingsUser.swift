// SettingsUser.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Каратакер для юзера( менеджер)
final class UserSevice {
    // MARK: - Constants

    private enum Constants {
        static let userDefaultsKey = "keyUser"
        static let imageKey = "keyImage"
    }

    static let shared = UserSevice()
    var user: User?
    var userAvatar: Data?

    // MARK: - Error

    public enum Error: Swift.Error {
        case userNo
    }

    private init(user: User? = nil) {
        self.user = user
    }

    // MARK: - Private Properties

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    // MARK: - Public Methods

    func save(user: some MementoUser) {
        do {
            let userData: Memento = try encoder.encode(user)
            UserDefaults.standard.set(userData, forKey: Constants.userDefaultsKey)
        } catch {}
    }

    func load() throws -> User {
        guard let userData = UserDefaults.standard.value(forKey: Constants.userDefaultsKey) as? Memento,
              let user = try? decoder.decode(User.self, from: userData) else { throw Error.userNo }
        loadImage()
        self.user = user
        return user
    }

    func saveImage(name: Data) {
        do {
            guard let data = UIImage(data: name)?.jpegData(compressionQuality: 0.5) else { return }
            let encoded = try PropertyListEncoder().encode(data)
            UserDefaults.standard.set(encoded, forKey: Constants.imageKey)
            userAvatar = encoded
        } catch {}
    }

    func loadImage() {
        do {
            guard let data = UserDefaults.standard.data(forKey: Constants.imageKey) else { return }
            let decoded = try PropertyListDecoder().decode(Data.self, from: data)
            userAvatar = decoded
        } catch {}
    }
}
