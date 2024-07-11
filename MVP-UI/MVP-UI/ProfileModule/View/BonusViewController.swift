// BonusViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран бонусов
final class BonusViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static var fontVerdana = "Verdana"
        static var titleYourBonuses = "Your bonuses"
        static var fontVerdanaBold = "Verdana-Bold"
        static var titleBonusPayment = "100"
    }

    // MARK: - Visual Components

    private let bonusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.fontVerdana, size: 20)
        label.text = Constants.titleYourBonuses
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var iconBonusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bonusIcon
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var iconStarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .starBonus
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let bonusPaymentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.fontVerdanaBold, size: 30)
        label.text = Constants.titleBonusPayment
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.closeButton, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeViewController), for: .touchUpInside)
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubview()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }

    // MARK: - Public Methods

    func changeBonus(item: String?) {
        guard let bonus = item else { return }
        bonusPaymentsLabel.text = bonus
    }

    // MARK: - Private Methods

    private func addSubview() {
        view.backgroundColor = .white
        view.addSubview(bonusLabel)
        view.addSubview(iconBonusImageView)
        view.addSubview(iconStarImageView)
        view.addSubview(bonusPaymentsLabel)
        view.addSubview(closeButton)
    }

    private func setupConstraints() {
        bonusLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        bonusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bonusLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        bonusLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true

        iconBonusImageView.topAnchor.constraint(equalTo: bonusLabel.bottomAnchor, constant: 15).isActive = true
        iconBonusImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconBonusImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        iconBonusImageView.heightAnchor.constraint(equalToConstant: 136).isActive = true

        iconStarImageView.topAnchor.constraint(equalTo: iconBonusImageView.bottomAnchor, constant: 25).isActive = true
        iconStarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 130).isActive = true
        iconStarImageView.widthAnchor.constraint(equalToConstant: 29).isActive = true
        iconStarImageView.heightAnchor.constraint(equalToConstant: 27).isActive = true

        bonusPaymentsLabel.centerYAnchor.constraint(equalTo: iconStarImageView.centerYAnchor).isActive = true
        bonusPaymentsLabel.leadingAnchor.constraint(equalTo: iconStarImageView.trailingAnchor, constant: -15)
            .isActive = true
        bonusPaymentsLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        bonusPaymentsLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true

        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 13).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 13).isActive = true
    }

    @objc private func closeViewController() {
        dismiss(animated: true)
    }
}
