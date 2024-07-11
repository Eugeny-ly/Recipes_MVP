// DetailMarkerViewController.swift
// Copyright © RoadMap. All rights reserved.

import GoogleMaps
import UIKit

/// Детальная информация маркера
final class DetailMarkerViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static var fontVerdana = "Verdana"
        static var titleYourBonuses = "Your bonuses"
        static var fontVerdanaBold = "Verdana-Bold"
        static var titleBonusPayment = "Your discount -30%"
        static var titleBonusPaymentDiscriptions = "Promocode RECIPE30"
    }

    // MARK: - Visual Components

    private let titleMarkerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.fontVerdanaBold, size: 20)
        label.textAlignment = .center
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let adressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.fontVerdana, size: 20)
        label.textAlignment = .center
        label.textColor = .gray
        label.numberOfLines = 1
        label.sizeToFit()
        label.layoutIfNeeded()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let discoutLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: Constants.fontVerdana, size: 16)
        text.text = Constants.titleBonusPayment
        text.textAlignment = .center
        text.textColor = .gray
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    private let discoutDiscriptionLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: Constants.fontVerdana, size: 16)
        text.text = Constants.titleBonusPaymentDiscriptions
        text.textAlignment = .center
        text.textColor = .gray
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.closeButton, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeViewController), for: .touchUpInside)
        return button
    }()

    var marker: GMSMarker? = nil

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeUI()
        addSubview()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }

    // MARK: - Private Methods

    private func addSubview() {
        view.backgroundColor = .white
        view.addSubview(titleMarkerLabel)
        view.addSubview(adressLabel)
        view.addSubview(closeButton)
        view.addSubview(discoutLabel)
        view.addSubview(discoutDiscriptionLabel)
    }

    private func makeUI() {
        titleMarkerLabel.text = marker?.title
        adressLabel.text = marker?.snippet
    }

    private func setupConstraints() {
        titleMarkerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        titleMarkerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleMarkerLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        titleMarkerLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true

        adressLabel.topAnchor.constraint(equalTo: titleMarkerLabel.bottomAnchor, constant: 8).isActive = true
        adressLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        adressLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        adressLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true

        discoutLabel.topAnchor.constraint(equalTo: adressLabel.bottomAnchor, constant: 43).isActive = true
        discoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        discoutLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        discoutLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        discoutLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        discoutDiscriptionLabel.topAnchor.constraint(equalTo: discoutLabel.bottomAnchor, constant: 13).isActive = true
        discoutDiscriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        discoutDiscriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
        discoutDiscriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        discoutDiscriptionLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 13).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 13).isActive = true
    }

    @objc private func closeViewController() {
        dismiss(animated: true)
    }
}
