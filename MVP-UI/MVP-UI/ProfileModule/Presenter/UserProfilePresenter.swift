// UserProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера
protocol UserProfilePresenterInputProtocol: AnyObject {
    /// Метод для тапа по ячейке
    func tapSelectItem(index: Int)
    /// Запрос пользователя
    func requestUser()
    /// Метод дляя обновления информации о пользователе
    func updateUserName(withName name: String)
    ///  Метод для экшена по кнопке
    func actionAlert()
    /// обновляем данные пользователя
    func updateUserInfo(avatar: Data)
    /// Открытие экрана с картой
    func showBonus()
}

/// Презентер экрана профиля
final class UserProfilePresenter {
    // MARK: - Constants

    private enum Constants {
        static let defaultLogin = "Нет Имени"
    }

    private weak var userCoordinator: UserProfileCoordinator?
    private weak var view: UserProfileViewInputProtocol?
    private var user: ProfileHeaderCellSource?
    private var userService = UserSevice.shared

    init(view: UserProfileViewInputProtocol?, userCoordinator: UserProfileCoordinator) {
        self.view = view
        self.userCoordinator = userCoordinator
    }
}

// MARK: - extension + UserProfileProtocol

extension UserProfilePresenter: UserProfilePresenterInputProtocol {
    func showBonus() {
        userCoordinator?.pushBonusViewController()
    }

    func updateUserInfo(avatar: Data) {
        let oldUser = userService
        let newUser = User(
            login: oldUser.user?.login ?? Constants.defaultLogin,
            emailTitle: oldUser.user?.emailTitle ?? "",
            passwordTitle: oldUser.user?.passwordTitle ?? ""
        )
        oldUser.saveImage(name: avatar)
        oldUser.loadImage()
        userService.save(user: newUser)
    }

    func actionAlert() {
        view?.showAlertChangeName()
    }

    func updateUserName(withName name: String) {
        user?.userName = name
        view?.setTitleNameUser(name: name)
        let oldUser = userService.user
        let newUser = User(
            login: name,
            emailTitle: oldUser?.emailTitle ?? "",
            passwordTitle: oldUser?.passwordTitle ?? ""
        )
        userService.save(user: newUser)
    }

    func tapSelectItem(index: Int) {
        switch index {
        case 0:
            view?.showBonusView()
        case 1:
            view?.showTermsPrivacyPolicy()
        case 2:
            userCoordinator?.pushCardViewController()
        default:
            break
        }
    }

    func requestUser() {
        let dataHeader = ProfileHeaderCellSource.getProfileHeader()
        let dataNavigation = ProfileNavigationCellSource.getProfileNavigation()
        let rowsType: [ProfileItem] = [
            .header(dataHeader),
            .navigation(dataNavigation)
        ]
        view?.updateTable(profileTable: rowsType)
    }

    func presentViewController() {
        // userCoordinator?.pushDetailViewController()
    }
}
