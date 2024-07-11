// RecipesCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с рецептами
final class RecipesCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let fontVerdana = "Verdana"
        static let timerImageViewName = "timer"
        static let pizzaImageViewName = "pizza"
        static let nextButtonImageName = "chevron.right"
        static let timeLabelText = " min"
        static let pizzaLabelText = " kkal"
    }

    // MARK: - Visual Components

    private let uiViewBackground: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 242 / 255, green: 245 / 255, blue: 250 / 255, alpha: 1.0)
        uiView.layer.cornerRadius = 12
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()

    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleRecipe: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont(name: Constants.fontVerdana, size: 14)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.fontVerdana, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.timerImageViewName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let pizzaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.pizzaImageViewName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let pizzaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.fontVerdana, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let nextButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: Constants.nextButtonImageName), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupViews()
        setupAnchors()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupAnchors()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        recipeImageView.image = nil
    }

    // MARK: - Public Methods

    func configure(with items: RecipeCommonInfo) {
        recipeImageView.downloaded(from: items.image)
        titleRecipe.text = items.label
        timeLabel.text = "\(items.totaltime)" + Constants.timeLabelText
        pizzaLabel.text = "\(items.calories)" + Constants.pizzaLabelText
    }

    // MARK: - Private Methods

    private func setupViews() {
        contentView.addSubview(uiViewBackground)
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleRecipe)
        contentView.addSubview(timeLabel)
        contentView.addSubview(timerImageView)
        contentView.addSubview(pizzaImageView)
        contentView.addSubview(pizzaLabel)
        contentView.addSubview(nextButton)
    }

    private func setupAnchors() {
        setupAnchorsUiViewBackground()
        setupAnchorsRecipeImageView()
        setupAnchorsTitleRecipe()
        setupAnchorsTimeLabel()
        setupAnchorsTimerImageView()
        setupAnchorsPizzaImageView()
        setupAnchorsPizzaLabel()
        setupAnchorsNextButton()
    }

    private func setupAnchorsUiViewBackground() {
        uiViewBackground.widthAnchor.constraint(equalToConstant: 338).isActive = true
        uiViewBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        uiViewBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        uiViewBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14).isActive = true
    }

    private func setupAnchorsRecipeImageView() {
        recipeImageView.leadingAnchor.constraint(equalTo: uiViewBackground.leadingAnchor, constant: 10)
            .isActive = true
        recipeImageView.topAnchor.constraint(equalTo: uiViewBackground.topAnchor, constant: 10).isActive = true
        recipeImageView.bottomAnchor.constraint(equalTo: uiViewBackground.bottomAnchor, constant: -10).isActive = true
        recipeImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }

    private func setupAnchorsTitleRecipe() {
        titleRecipe.topAnchor.constraint(equalTo: uiViewBackground.topAnchor, constant: 22).isActive = true
        titleRecipe.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 20).isActive = true
        titleRecipe.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }

    private func setupAnchorsTimeLabel() {
        timeLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 40).isActive = true
        timeLabel.topAnchor.constraint(equalTo: titleRecipe.bottomAnchor, constant: 20).isActive = true
    }

    private func setupAnchorsTimerImageView() {
        timerImageView.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 22)
            .isActive = true
        timerImageView.topAnchor.constraint(equalTo: titleRecipe.bottomAnchor, constant: 19).isActive = true
    }

    private func setupAnchorsPizzaImageView() {
        pizzaImageView.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 37).isActive = true
        pizzaImageView.topAnchor.constraint(equalTo: titleRecipe.bottomAnchor, constant: 19).isActive = true
    }

    private func setupAnchorsPizzaLabel() {
        pizzaLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 55).isActive = true
        pizzaLabel.topAnchor.constraint(equalTo: titleRecipe.bottomAnchor, constant: 20).isActive = true
    }

    private func setupAnchorsNextButton() {
        nextButton.trailingAnchor.constraint(equalTo: uiViewBackground.trailingAnchor, constant: -16)
            .isActive = true
        nextButton.topAnchor.constraint(equalTo: uiViewBackground.topAnchor, constant: 40).isActive = true
    }
}
