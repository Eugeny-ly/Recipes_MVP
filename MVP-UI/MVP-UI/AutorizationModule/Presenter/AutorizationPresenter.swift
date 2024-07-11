// AutorizationPresenter.swift
// Copyright © RoadMap. All rights reserved.

import KeychainSwift
import UIKit

/// Протокол авторизации
protocol AutorizationProtocol: AnyObject {
    /// Проверка логина
    func chekUser(login: String?)
    /// Проверка пароля
    func chekPassword(password: String?, login: String?)
}

/// Протокол авторизации вью
protocol AutorizationViewControllerProtocol: AnyObject {
    /// Меняем цвет тайтлу  при проверки валидности логина
    func setTitleColorLogin(color: String, isValidateLogin: Bool)
    /// Меняем цвет тайтлу  при проверки валидности пароля
    func setTitleColorPassword(color: String, isValidatePassword: Bool)
    /// Проверка юзера на валидность
    func chekValidateUser(imageButton: String?, titleButton: String?)
    /// Показать сплеш
    func showSpashScreenOn()
    /// Скрыть сплеш
    func showSpashScreenOff()
    /// Сохранение пользователя
    func saveUser(email: String, password: String)
}

/// Презентер для экрана с авторизацией
final class AutorizationPresenter {
    // MARK: - Constants

    private enum Constants {
        static let splashRedColor = "splashColor"
        static let labelDefaultColor = "сolorIconTabBar"
        static let loader = "loader"
        static let login = "Login"
        static let suffix = "@"
        static let timer: CGFloat = 3
        static let value = 6
    }

    // MARK: - State User

    enum StateUser {
        /// не авторизирован
        case non
        /// аккаунт подтвержден
        case verification
        /// ошибка авторизации
        case noVerification
    }

    // MARK: - Private Properties

    private weak var view: AutorizationViewControllerProtocol?
    private weak var autorizationCoordinator: AutorizationCoordinator?
    private var stateUser: StateUser = .non
    private let userService = UserSevice.shared
    private let keychain = KeychainSwift()

    // MARK: - Init

    init(view: AutorizationViewControllerProtocol, coordinator: AutorizationCoordinator) {
        self.view = view
        autorizationCoordinator = coordinator
    }

    private func goToMainTabBarScreen() {
        autorizationCoordinator?.showMainViewController()
    }

    /// Сохраняем юзера в Keychain
    func saveUser(email: String, password: String) {
        keychain.set(email, forKey: "email")
        keychain.set(password, forKey: "password")
        goToMainTabBarScreen()
    }

    /// Проверяем верификацию пользователя из Keychain
    func checkVerificationUser(email: String, password: String) {
        if let savedEmail = keychain.get("email"), let savedPassword = keychain.get("password") {
            if savedEmail != email || savedPassword != password {
                stateUser = .noVerification
            } else {
                stateUser = .verification
            }
        } else {
            stateUser = .non
        }
    }

    private func validatePassword() {
        view?.chekValidateUser(imageButton: Constants.loader, titleButton: nil)
        view?.showSpashScreenOff()
        view?.setTitleColorLogin(color: Constants.labelDefaultColor, isValidateLogin: true)
        view?.setTitleColorPassword(color: Constants.labelDefaultColor, isValidatePassword: true)
    }
}

// MARK: - AutorizationProtocol

extension AutorizationPresenter: AutorizationProtocol {
    func chekPassword(password: String?, login: String?) {
        guard let login = login else { return }
        guard let password = password else { return }
        switch password.count {
        case 0 ... 5:
            view?.showSpashScreenOn()
            view?.setTitleColorPassword(color: Constants.splashRedColor, isValidatePassword: false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.view?.showSpashScreenOff()
                self.view?.setTitleColorLogin(color: Constants.labelDefaultColor, isValidateLogin: true)
                self.view?.setTitleColorPassword(color: Constants.labelDefaultColor, isValidatePassword: true)
            }
        default:
            validatePassword()
            checkVerificationUser(email: login, password: password)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                switch self.stateUser {
                case .non:
                    self.saveUser(email: login, password: password)
                case .verification:
                    self.goToMainTabBarScreen()
                case .noVerification:
                    self.view?.showSpashScreenOn()
                    self.view?.chekValidateUser(imageButton: nil, titleButton: Constants.login)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.view?.showSpashScreenOff()
                    }
                }
            }
        }
    }

    func chekUser(login: String?) {
        guard let login = login else { return }
        if !login.hasSuffix(Constants.suffix), !login.isEmpty {
            view?.setTitleColorLogin(color: Constants.splashRedColor, isValidateLogin: false)
        } else {
            view?.setTitleColorLogin(color: Constants.labelDefaultColor, isValidateLogin: true)
        }
    }
}
