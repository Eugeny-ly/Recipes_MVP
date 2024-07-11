// DetailsHeaderCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка картинки, время приготовления блюда
final class DetailsHeaderCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let fontVerdana = "Verdana"
        static let fontVerdanaBold = "Verdana-Bold"
        static let titleCookingTime = "Cooking time"
        static let indent = " "
        static let titleMinutesTime = "min"
    }

    // MARK: - Visual Components

    private let nameRecipeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Constants.fontVerdanaBold, size: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()

    private let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let backgroundPortionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.selectedIconTabBarColor(alpha: 0.85)
        view.alpha = 0.85
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let backgroundCookingTimeView: UIView = {
        let view = UIView()
        view.backgroundColor = .selectedIconTabBar
        view.layer.cornerRadius = 25
        view.alpha = 0.85
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let potImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .pot
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let portionWeightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.fontVerdana, size: 10)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .timerWhite
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleCookingTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.fontVerdana, size: 10)
        label.textColor = .white
        label.text = Constants.titleCookingTime
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let cookingTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.fontVerdana, size: 10)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Public Properties

    static let identifier = NSStringFromClass(DetailsHeaderCell.self)

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupViews()
        setupConstraints()
        cornerRoundingView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
        cornerRoundingView()
    }

    // MARK: - Public Methods

    func configure(info: RecipeDetail) {
        nameRecipeLabel.text = info.label
        foodImageView.downloaded(from: info.images)
        portionWeightLabel.text = String(info.totalWeight)
        cookingTimeLabel.text = "\(info.totalTime)" + Constants.indent + Constants.titleMinutesTime
    }

    // MARK: - Private Methods

    private func cornerRoundingView() {
        DispatchQueue.main.async {
            self.backgroundPortionView.layer.cornerRadius = self.backgroundPortionView.frame.size.width / 2
        }
    }

    private func setupViews() {
        contentView.addSubview(nameRecipeLabel)
        contentView.addSubview(foodImageView)
        foodImageView.addSubview(backgroundPortionView)
        foodImageView.addSubview(backgroundCookingTimeView)
        backgroundPortionView.addSubview(potImageView)
        backgroundPortionView.addSubview(portionWeightLabel)
        backgroundCookingTimeView.addSubview(timerImageView)
        backgroundCookingTimeView.addSubview(titleCookingTimeLabel)
        backgroundCookingTimeView.addSubview(cookingTimeLabel)
    }

    private func setupConstraints() {
        nameRecipeLabelConstraints()
        foodImageConstraints()
        backgroundPortionConstraints()
        backgroundCookingTimeConstraints()
        potConstraints()
        portionWeightConstraint()
        timerImageConstraint()
        titleCookingTimeConstraint()
        cookingTimeConstraint()
    }

    private func nameRecipeLabelConstraints() {
        nameRecipeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        nameRecipeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        nameRecipeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }

    private func foodImageConstraints() {
        foodImageView.topAnchor.constraint(equalTo: nameRecipeLabel.bottomAnchor, constant: 10).isActive = true
        foodImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        foodImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        foodImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }

    private func backgroundPortionConstraints() {
        backgroundPortionView.topAnchor.constraint(equalTo: foodImageView.topAnchor, constant: 10).isActive = true
        backgroundPortionView.trailingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: -15)
            .isActive = true
        backgroundPortionView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        backgroundPortionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func backgroundCookingTimeConstraints() {
        backgroundCookingTimeView.bottomAnchor.constraint(equalTo: foodImageView.bottomAnchor).isActive = true
        backgroundCookingTimeView.trailingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 15)
            .isActive = true
        backgroundCookingTimeView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        backgroundCookingTimeView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func potConstraints() {
        potImageView.centerXAnchor.constraint(equalTo: backgroundPortionView.centerXAnchor).isActive = true
        potImageView.topAnchor.constraint(equalTo: backgroundPortionView.topAnchor, constant: 7).isActive = true
        potImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        potImageView.heightAnchor.constraint(equalToConstant: 17).isActive = true
    }

    private func portionWeightConstraint() {
        portionWeightLabel.centerXAnchor.constraint(equalTo: backgroundPortionView.centerXAnchor).isActive = true
        portionWeightLabel.bottomAnchor.constraint(equalTo: backgroundPortionView.bottomAnchor, constant: -10)
            .isActive = true
        portionWeightLabel.widthAnchor.constraint(equalToConstant: 35).isActive = true
        portionWeightLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }

    private func timerImageConstraint() {
        timerImageView.centerYAnchor.constraint(equalTo: backgroundCookingTimeView.centerYAnchor).isActive = true
        timerImageView.leadingAnchor.constraint(equalTo: backgroundCookingTimeView.leadingAnchor, constant: 8)
            .isActive = true
        timerImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        timerImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func titleCookingTimeConstraint() {
        titleCookingTimeLabel.centerXAnchor.constraint(equalTo: backgroundCookingTimeView.centerXAnchor).isActive = true
        titleCookingTimeLabel.topAnchor.constraint(equalTo: backgroundCookingTimeView.topAnchor, constant: 10)
            .isActive = true
        titleCookingTimeLabel.widthAnchor.constraint(equalToConstant: 83).isActive = true
        titleCookingTimeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

    private func cookingTimeConstraint() {
        cookingTimeLabel.topAnchor.constraint(equalTo: titleCookingTimeLabel.bottomAnchor).isActive = true
        cookingTimeLabel.centerXAnchor.constraint(equalTo: titleCookingTimeLabel.centerXAnchor)
            .isActive = true
        cookingTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        cookingTimeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
}
