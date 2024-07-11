// ShimerHeaderViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Шимер для ячейки с КБЖУ
final class ShimerHeaderViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let gradientKey = "shimerCell"
        static let valueTime: CGFloat = 0.33
        static let valueTimeInterval: CGFloat = 1.5
    }

    // MARK: - Visual Components

    private let foodImageView: UIView = {
        let imageView = UIView()
        imageView.widthAnchor.constraint(equalToConstant: 78).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 53).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let gradientBackground = CAGradientLayer()

    // MARK: - Private Properties

    private lazy var firstBackgroundElements = makeBackgroundElementsImageView()
    private lazy var secondBackgroundElements = makeBackgroundElementsImageView()
    private lazy var thirdBackgroundElements = makeBackgroundElementsImageView()
    private lazy var fourthBackgroundElements = makeBackgroundElementsImageView()

    private lazy var nutrientsTitleStackView = UIStackView(
        arrangedsSubviews: [
            firstBackgroundElements,
            secondBackgroundElements,
            thirdBackgroundElements,
            fourthBackgroundElements
        ],
        axis: .horizontal,
        spacing: 15
    )

    static let identifier = NSStringFromClass(ShimerHeaderViewCell.self)

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        addGradient()
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        addGradient()
        setupGradiBackground(view: nutrientsTitleStackView)
        setupGradiBackground(view: nutrientsTitleStackView)
    }

    // MARK: - Private Methods

    private func setupViews() {
        contentView.addSubview(nutrientsTitleStackView)
    }

    private func makeBackgroundElementsImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = .backgroundCbgu
        imageView.tintColor = UIColor.selectedIconTabBar
        imageView.widthAnchor.constraint(equalToConstant: 78).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 53).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

    private func setupGradiBackground(view: UIView) {
        gradientBackground.startPoint = CGPoint(x: 0, y: 0.5)
        gradientBackground.endPoint = CGPoint(x: 1, y: 0.5)
        gradientBackground.frame = view.bounds
        gradientBackground.cornerRadius = 12
        view.layer.addSublayer(gradientBackground)
        view.layer.addSublayer(gradientBackground)
        view.layer.addSublayer(gradientBackground)
        view.layer.addSublayer(gradientBackground)
    }

    private func addGradient() {
        let viewBackgroundGroup = makeAnimation()
        viewBackgroundGroup.beginTime = 0.0
        gradientBackground.add(viewBackgroundGroup, forKey: Constants.gradientKey)
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

    private func setupConstraints() {
        backgroundStackViewConstraints()
    }

    private func backgroundStackViewConstraints() {
        nutrientsTitleStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
}
