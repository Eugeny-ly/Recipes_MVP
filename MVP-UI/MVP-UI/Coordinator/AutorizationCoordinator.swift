// AutorizationCoordinator.swift
// Copyright © RoadMap. All rights reserved.

//
//  AutorizationCoordinator.swift
//  MVP-UI
//
//
import UIKit

/// Координатор авторизации
final class AutorizationCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController?
    var onFinishFlow: VoidHandler?
    let authViewController = AutorizationViewController()

    override func start() {
        showAutorizationViewController()
    }

    func setEmailDiplink(email: String? = nil) {
        authViewController.setDipLinkEmail(email: email)
    }

    func showAutorizationViewController() {
        let loginPresenter = AutorizationPresenter(view: authViewController, coordinator: self)
        authViewController.autorizationPresenter = loginPresenter
        let rootViewController = UINavigationController(rootViewController: authViewController)
        setAsRoot​(​_​: rootViewController)
        self.rootViewController = rootViewController
    }

    func showMainViewController() {
        onFinishFlow?()
    }
}
