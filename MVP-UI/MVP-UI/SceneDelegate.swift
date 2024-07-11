// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import Swinject
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var applicationCoordinator: ApplicationCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        configureSceneDelegate(windowScene: windowScene)
    }

    private func configureSceneDelegate(windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)

        let serviceDistributor = Container()
        let builder = AppBulder(serviceDistributor: serviceDistributor)
        if let window {
            builder.makeConteiner()
            window.makeKeyAndVisible()
            applicationCoordinator = ApplicationCoordinator(appBuilder: builder, conteiner: serviceDistributor)
            applicationCoordinator?.start()
        }
    }

    // recipesProject://openScreen/screen=favorites
    // recipesProject://openScreen/screen=userProfile
    // recipesProject://openScreen/screen=main/vaka@

    // swiftlint:disable all
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let firstURL = URLContexts.first,
              let components = URLComponents(url: firstURL.url, resolvingAgainstBaseURL: true)
        else { return }
        switch components.host {
        case "openScreen":
            openScreen(urlItems: components.path)
        default:
            break
        }
    }

    // swiftlint:enable all
    func openScreen(urlItems: String) {
        let screenQuery = urlItems.sliceMultipleTimes(from: "=", to: "/")

        switch screenQuery.first {
        case "favorites":
            applicationCoordinator?.dipLinkSelected(selected: .favorites)
        case "userProfile":
            applicationCoordinator?.dipLinkSelected(selected: .userProfile)
        case "main":
            applicationCoordinator?.dipLinkSelected(selected: .main, itemBonus: "Vaka@")
        default:
            break
        }
    }
}

extension String {
    func sliceMultipleTimes(from: String, to: String) -> [String] {
        components(separatedBy: from).dropFirst().compactMap { sub in
            (sub.range(of: to)?.lowerBound).flatMap { endRange in
                String(sub[sub.startIndex ..< endRange])
            }
        }
    }
}
