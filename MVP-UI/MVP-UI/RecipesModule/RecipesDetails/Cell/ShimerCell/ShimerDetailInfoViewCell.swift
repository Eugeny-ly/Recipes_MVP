// ShimerDetailInfoViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Шимер для ячейки с картинкой
final class ShimerDetailInfoViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let gradientKey = "shimerCell"
        static let valueTime: CGFloat = 0.33
        static let valueTimeInterval: CGFloat = 1.5
    }

    // MARK: - Visual Components

    private let foodImageView: UIView = {
        let imageView = UIView()
        imageView.layer.cornerRadius = 40
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let gradientBackground = CAGradientLayer()

    // MARK: - Public Properties

    static let identifier = NSStringFromClass(ShimerDetailInfoViewCell.self)

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
        setupGradiBackground()
    }

    // MARK: - Private Methods

    private func setupViews() {
        contentView.addSubview(foodImageView)
    }

    private func setupGradiBackground() {
        gradientBackground.startPoint = CGPoint(x: 0.5, y: 0)
        gradientBackground.endPoint = CGPoint(x: 0.5, y: 1)
        gradientBackground.frame = foodImageView.bounds
        gradientBackground.cornerRadius = 12
        foodImageView.layer.addSublayer(gradientBackground)
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
        foodImageConstraints()
    }

    private func foodImageConstraints() {
        foodImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        foodImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        foodImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        foodImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
}
