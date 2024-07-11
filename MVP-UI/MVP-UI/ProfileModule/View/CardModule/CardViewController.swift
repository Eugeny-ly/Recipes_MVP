// CardViewController.swift
// Copyright © RoadMap. All rights reserved.

import CoreLocation
import Foundation
import GoogleMaps
import UIKit

/// Экран с картой
final class CardViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let textTitleEmptyView = Local.Map.title
        static let doneTitle = "Ok"
    }

    // MARK: - Visual Components

    private let emptyView: UIView = {
        let empty = UIView()
        empty.backgroundColor = .white
        return empty
    }()

    private let titleEmptyView: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.text = Constants.textTitleEmptyView
        text.font = UIFont.systemFont(ofSize: 18)
        text.sizeToFit()
        text.numberOfLines = 2
        return text
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.doneTitle, for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        return button
    }()

    private lazy var userLocationButton: UIButton = {
        let location = UIButton()
        location.backgroundColor = .white
        location.layer.cornerRadius = 10
        location.setImage(UIImage(systemName: "location"), for: .normal)
        location.imageView?.tintColor = .black
        location.addTarget(self, action: #selector(currentLocation), for: .touchUpInside)
        return location
    }()

    // MARK: - Public Properties

    var presenter: CardPresenter?

    // MARK: - Private Properties

    private let options = GMSMapViewOptions()
    private var mapView = GMSMapView()
    private let marker = GMSMarker()
    private var locationManager = CLLocationManager()
    private var lastUserLocation: CLLocation = .init(latitude: 57.014888, longitude: 40.977455)

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    // MARK: - Private Methods

    private func configureView() {
        makeLocationManager()
        makeNavController()
        configureEmptyView()
        makeOptionsMap()
        makeMapView()
        makeLabel()
        makeButton()
        makeLocation()
        configureMarker()
    }

    private func makeNavController() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.tabBarController?.tabBar.isHidden = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .done,
            target: self,
            action: #selector(dismissViewController)
        )
    }

    private func makeOptionsMap() {
        options.camera = GMSCameraPosition(target: lastUserLocation.coordinate, zoom: 14)
        marker.position = lastUserLocation.coordinate
        options.frame = view.bounds
    }

    private func makeMapView() {
        mapView = GMSMapView(options: options)
        mapView.delegate = self
        view.addSubview(mapView)
        marker.title = "Я"
        marker.icon = GMSMarker.markerImage(with: .blue)
        marker.snippet = "Тута"
        marker.map = mapView
        makeAnchorMap()
    }

    private func configureEmptyView() {
        view.addSubview(emptyView)
        makeAnchorEmptyView()
    }

    private func makeLabel() {
        emptyView.addSubview(titleEmptyView)
        makeAnchorTitleEmptyView()
    }

    private func makeButton() {
        emptyView.addSubview(closeButton)
        makeAnchorTitleCloseButton()
    }

    private func makeLocation() {
        view.addSubview(userLocationButton)
        makeAnchorLocationButton()
    }

    private func makeLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
        guard let location = locationManager.location else { return }
        lastUserLocation = location
    }

    private func configureMarker() {
        let coordinateCulturalPark = CLLocationCoordinate2D(latitude: 57.013099, longitude: 40.953573)
        let markerCulturalPark = GMSMarker(position: coordinateCulturalPark)
        markerCulturalPark.title = "Центральный парк"
        markerCulturalPark.snippet = "Иваново, ул.Пушкина дом Колотушкина"

        let coordinateCafeChao = CLLocationCoordinate2D(latitude: 56.999353, longitude: 40.955247)
        let markerMacDonalds = GMSMarker(position: coordinateCafeChao)
        markerMacDonalds.title = "McDonalds"
        markerMacDonalds.snippet = "Иваново, Ул.Ленина 5/2"

        let coordinatePlant = CLLocationCoordinate2D(latitude: 57.000865, longitude: 40.996618)
        let markerCafe = GMSMarker(position: coordinatePlant)
        markerCafe.title = "Кафе РМ"
        markerCafe.snippet = "Иваново, Ул.Грачева 5/2"

        let orphanage = CLLocationCoordinate2D(latitude: 56.988219, longitude: 40.976530)
        let markerPizza = GMSMarker(position: orphanage)
        markerPizza.title = "Пиццерия приятного аппетита"
        markerPizza.snippet = "Иваново, Ул.Лермонтова 6"

        let terskayaVillage = CLLocationCoordinate2D(latitude: 56.991915, longitude: 41.001890)
        let markerCentralCafe = GMSMarker(position: terskayaVillage)
        markerCentralCafe.title = "Центральное кафе"
        markerCentralCafe.snippet = "Иваново, ул. Калинина 13/37"

        let derzhavnayaChurch = CLLocationCoordinate2D(latitude: 56.974691, longitude: 40.981897)
        let markerDodo = GMSMarker(position: derzhavnayaChurch)
        markerDodo.title = "Pizza DODO"
        markerDodo.snippet = "Иваново, ул.Виктора Бодрова 1"

        markerCulturalPark.map = mapView
        markerCafe.map = mapView
        markerPizza.map = mapView
        markerCentralCafe.map = mapView
        markerDodo.map = mapView
        markerMacDonalds.map = mapView
    }

    @objc private func dismissViewController() {
        presenter?.dismiss()
    }

    @objc private func currentLocation() {
        locationManager.startUpdatingLocation()
        if let location = locationManager.location {
            lastUserLocation = location
        }
        userLocationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
        if let locationManager = locationManager.location?.coordinate {
            mapView.animate(toLocation: locationManager)
            marker.position = locationManager
            mapView.animate(toZoom: 14)
        }
    }
}

// MARK: - Extension + Constraints

extension CardViewController {
    private func makeAnchorEmptyView() {
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        emptyView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 3).isActive = true
        emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func makeAnchorMap() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: emptyView.topAnchor).isActive = true
    }

    private func makeAnchorTitleEmptyView() {
        titleEmptyView.translatesAutoresizingMaskIntoConstraints = false
        titleEmptyView.leadingAnchor.constraint(equalTo: emptyView.layoutMarginsGuide.leadingAnchor).isActive = true
        titleEmptyView.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 40).isActive = true
        titleEmptyView.trailingAnchor.constraint(equalTo: emptyView.layoutMarginsGuide.trailingAnchor).isActive = true
        titleEmptyView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }

    private func makeAnchorTitleCloseButton() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.leadingAnchor.constraint(equalTo: emptyView.layoutMarginsGuide.leadingAnchor).isActive = true
        closeButton.topAnchor.constraint(equalTo: titleEmptyView.bottomAnchor, constant: 60).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: emptyView.layoutMarginsGuide.trailingAnchor).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }

    private func makeAnchorLocationButton() {
        userLocationButton.translatesAutoresizingMaskIntoConstraints = false
        userLocationButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        userLocationButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20).isActive = true
        userLocationButton.widthAnchor.constraint(equalToConstant: 52).isActive = true
        userLocationButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -14).isActive = true
    }
}

// MARK: - CardViewController + CardViewPtocol

extension CardViewController: CardViewPtocol {}

// MARK: - CardViewController + GMSMapViewDelegate

extension CardViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        userLocationButton.setImage(UIImage(systemName: "location"), for: .normal)
    }

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        presenter?.pushDetailMarker(marker: marker)
        return true
    }
}

extension CardViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {}

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}
