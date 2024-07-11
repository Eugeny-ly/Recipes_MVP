// CardPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import GoogleMaps

/// Протокол для вью с картой
protocol CardViewPtocol: AnyObject {}

/// Протокол для работы вью с презентором
protocol CardPresenterProtocol: AnyObject {
    /// Закрытие экрана с картой
    func dismiss()
    /// Открытие деталей маркера
    func pushDetailMarker(marker: GMSMarker)
}

/// Презентер экрана с картой
final class CardPresenter {
    private weak var view: CardViewPtocol?
    private weak var coordinator: UserProfileCoordinator?

    init(view: CardViewPtocol, coordinator: UserProfileCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}

// MARK: - CardPresenter + CardPresenterProtocol

extension CardPresenter: CardPresenterProtocol {
    func pushDetailMarker(marker: GMSMarker) {
        coordinator?.showMarkerInfo(marker: marker)
    }

    func dismiss() {
        coordinator?.dismiss()
    }
}
