// ShimerViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с шимером
final class ShimerViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let gradientKey = "shimerCell"
        static let valueTime: CGFloat = 0.33
        static let valueTimeInterval: CGFloat = 1.5
    }

    // MARK: - VIsual Components

    private let uiViewBackground: UIView = {
        let uiView = UIView()
        uiView.layer.cornerRadius = 12
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()

    private let recipeImageView = UIImageView()
    private let titleRecipe = UILabel()
    private let timeLabel = UILabel()
    private let timerImageView = UIImageView()
    private let pizzaImageView = UIImageView()
    private let pizzaLabel = UILabel()
    public let nextButton = UIButton()

    // MARK: - Private Properties

    private let gradientBackground = CAGradientLayer()
    private let gradientImage = CAGradientLayer()
    private let gradientTitle = CAGradientLayer()
    private let gradientTimelabel = CAGradientLayer()
    private let gradientPizzalabel = CAGradientLayer()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupTamic()
        setupViews()
        setupAnchors()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTamic()
        setupViews()
        setupAnchors()
    }

    // MARK: - Life Cycle

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        addGradient()
        setupGradiBackground()
        setupGradientImage()
        setupGradientTitle()
        setupGradientTimelabel()
        setupGradientPizzalabel()
    }

    // MARK: - Private Methods

    private func setupTamic() {
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        titleRecipe.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timerImageView.translatesAutoresizingMaskIntoConstraints = false
        pizzaImageView.translatesAutoresizingMaskIntoConstraints = false
        pizzaLabel.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
    }

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

    private func setupGradiBackground() {
        gradientBackground.startPoint = CGPoint(x: 0, y: 0.5)
        gradientBackground.endPoint = CGPoint(x: 1, y: 0.5)
        gradientBackground.frame = uiViewBackground.bounds
        gradientBackground.cornerRadius = 12
        uiViewBackground.layer.addSublayer(gradientBackground)
    }

    private func setupGradientImage() {
        gradientImage.startPoint = CGPoint(x: 0, y: 0.5)
        gradientImage.endPoint = CGPoint(x: 1, y: 0.5)
        gradientImage.cornerRadius = 12
        gradientImage.frame = recipeImageView.bounds
        recipeImageView.layer.addSublayer(gradientImage)
    }

    private func setupGradientTitle() {
        gradientTitle.startPoint = CGPoint(x: 0, y: 0.5)
        gradientTitle.endPoint = CGPoint(x: 1, y: 0.5)
        gradientTitle.frame = titleRecipe.bounds
        titleRecipe.layer.addSublayer(gradientTitle)
    }

    private func setupGradientTimelabel() {
        gradientTimelabel.startPoint = CGPoint(x: 1, y: 0.5)
        gradientTimelabel.endPoint = CGPoint(x: 0, y: 0.5)
        gradientTimelabel.frame = timeLabel.bounds
        timeLabel.layer.addSublayer(gradientTimelabel)
    }

    private func setupGradientPizzalabel() {
        gradientPizzalabel.startPoint = CGPoint(x: 1, y: 0.5)
        gradientPizzalabel.endPoint = CGPoint(x: 0, y: 0.5)
        gradientPizzalabel.frame = pizzaLabel.bounds
        pizzaLabel.layer.addSublayer(gradientPizzalabel)
    }

    private func addGradient() {
        let viewBackgroundGroup = makeAnimation()
        viewBackgroundGroup.beginTime = 0.0
        gradientBackground.add(viewBackgroundGroup, forKey: Constants.gradientKey)

        let imageGroup = makeAnimation(previousGroup: viewBackgroundGroup)
        gradientImage.add(imageGroup, forKey: Constants.gradientKey)

        let titleGroup = makeAnimation(previousGroup: viewBackgroundGroup)
        gradientTitle.add(titleGroup, forKey: Constants.gradientKey)

        let timeGroup = makeAnimation(previousGroup: viewBackgroundGroup)
        gradientTimelabel.add(timeGroup, forKey: Constants.gradientKey)

        let pizzaGroup = makeAnimation(previousGroup: viewBackgroundGroup)
        gradientPizzalabel.add(pizzaGroup, forKey: Constants.gradientKey)
    }

    private func makeAnimation(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
        let animDuration: CFTimeInterval = Constants.valueTimeInterval

        let animation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        animation.fromValue = UIColor.lightGray.cgColor
        animation.toValue = UIColor.white.cgColor
        animation.duration = animDuration
        animation.beginTime = 0.0

        let secondAnimation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        secondAnimation.fromValue = UIColor.white.cgColor
        secondAnimation.toValue = UIColor.lightGray.cgColor
        secondAnimation.duration = animDuration
        secondAnimation.beginTime = animation.beginTime + secondAnimation.duration

        let group = CAAnimationGroup()
        group.animations = [animation, secondAnimation]
        group.repeatCount = .greatestFiniteMagnitude
        group.duration = secondAnimation.beginTime + animation.duration
        group.isRemovedOnCompletion = false

        if let previousGroup = previousGroup {
            group.beginTime = previousGroup.beginTime + Constants.valueTime
        }
        return group
    }
}

// MARK: - ShimerViewCell + Constraints

private extension ShimerViewCell {
    func setupAnchorsUiViewBackground() {
        uiViewBackground.widthAnchor.constraint(equalToConstant: 338).isActive = true
        uiViewBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        uiViewBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        uiViewBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14).isActive = true
    }

    func setupAnchorsRecipeImageView() {
        recipeImageView.leadingAnchor.constraint(equalTo: uiViewBackground.leadingAnchor, constant: 10).isActive = true
        recipeImageView.topAnchor.constraint(equalTo: uiViewBackground.topAnchor, constant: 10).isActive = true
        recipeImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        recipeImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }

    func setupAnchorsTitleRecipe() {
        titleRecipe.topAnchor.constraint(equalTo: uiViewBackground.topAnchor, constant: 22).isActive = true
        titleRecipe.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 20).isActive = true
        titleRecipe.widthAnchor.constraint(equalToConstant: 200).isActive = true
        titleRecipe.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    func setupAnchorsTimeLabel() {
        timeLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 20).isActive = true
        timeLabel.topAnchor.constraint(equalTo: titleRecipe.bottomAnchor, constant: 20).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 74).isActive = true
    }

    func setupAnchorsTimerImageView() {
        timerImageView.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 22).isActive = true
        timerImageView.topAnchor.constraint(equalTo: titleRecipe.bottomAnchor, constant: 19).isActive = true
    }

    func setupAnchorsPizzaImageView() {
        pizzaImageView.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 37).isActive = true
        pizzaImageView.topAnchor.constraint(equalTo: titleRecipe.bottomAnchor, constant: 19).isActive = true
    }

    func setupAnchorsPizzaLabel() {
        pizzaLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 35).isActive = true
        pizzaLabel.topAnchor.constraint(equalTo: titleRecipe.bottomAnchor, constant: 20).isActive = true
        pizzaLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        pizzaLabel.widthAnchor.constraint(equalToConstant: 91).isActive = true
    }

    func setupAnchorsNextButton() {
        nextButton.trailingAnchor.constraint(equalTo: uiViewBackground.trailingAnchor, constant: -16).isActive = true
        nextButton.topAnchor.constraint(equalTo: uiViewBackground.topAnchor, constant: 40).isActive = true
    }
}
