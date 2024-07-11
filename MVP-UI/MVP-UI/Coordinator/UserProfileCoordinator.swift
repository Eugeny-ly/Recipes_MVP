// UserProfileCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import GoogleMaps
import UIKit

/// Координатор для  профиля
final class UserProfileCoordinator: BaseCoordinator {
    // MARK: - Constants

    private enum Constants {
        static let title = "Our Partners"
    }

    var rootViewController: UINavigationController?

    func setRootController(viewController: UIViewController) {
        rootViewController = UINavigationController(rootViewController: viewController)
    }

    func pushCardViewController() {
        let cardViewController = CardViewController()
        let presenter = CardPresenter(view: cardViewController, coordinator: self)
        cardViewController.presenter = presenter
        cardViewController.tabBarController?.tabBar.isHidden = true
        cardViewController.title = Constants.title
        cardViewController.navigationItem.hidesBackButton = true
        rootViewController?.pushViewController(cardViewController, animated: true)
    }

    func pushBonusViewController(itemBonus: String? = nil) {
        let bonusViewController = BonusViewController()
        if let sheetPresentationController = bonusViewController.sheetPresentationController {
            sheetPresentationController.detents = [.medium()]
            sheetPresentationController.preferredCornerRadius = 30
            sheetPresentationController.prefersScrollingExpandsWhenScrolledToEdge = false
            sheetPresentationController.prefersGrabberVisible = true
            sheetPresentationController.prefersEdgeAttachedInCompactHeight = true
        }
        bonusViewController.changeBonus(item: itemBonus)
        rootViewController?.present(bonusViewController, animated: true, completion: nil)
    }

    func dismiss() {
        rootViewController?.popViewController(animated: true)
    }

    func showMarkerInfo(marker: GMSMarker) {
        let detailMarkerViewController = DetailMarkerViewController()
        detailMarkerViewController.marker = marker

        if let sheetPresentationController = detailMarkerViewController.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheetPresentationController.detents = [.custom(resolver: { _ in
                    300
                })]
            } else {
                sheetPresentationController.detents = [.medium()]
            }
            sheetPresentationController.preferredCornerRadius = 30
            sheetPresentationController.prefersScrollingExpandsWhenScrolledToEdge = false
            sheetPresentationController.prefersGrabberVisible = true
            sheetPresentationController.prefersEdgeAttachedInCompactHeight = true
        }
        rootViewController?.present(detailMarkerViewController, animated: true)
    }
}
