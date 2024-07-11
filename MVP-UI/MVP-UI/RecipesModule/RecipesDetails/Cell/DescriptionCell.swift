// DescriptionCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка описания рецепта
final class DescriptionCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let fontVerdana = "Verdana"
        static let topGradientColor = UIColor.backgroundDescription
        static let bottomGradientColor = UIColor.white
    }

    // MARK: - Visual Components

    private let bacgroundDescription: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.fontVerdana, size: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Public Properties

    static let identifier = NSStringFromClass(DescriptionCell.self)

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        makeGradient()
    }

    // MARK: - Public Methods

    func configure(info: RecipeDetail) {
        descriptionLabel.text = info.ingridientLines.joined(separator: "\n")
    }

    // MARK: - Private Methods

    private func setupViews() {
        contentView.addSubview(bacgroundDescription)
        bacgroundDescription.addSubview(descriptionLabel)
    }

    private func makeGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = bacgroundDescription.bounds
        gradient.cornerRadius = 24
        gradient.colors = [Constants.topGradientColor.cgColor, Constants.bottomGradientColor.cgColor]
        bacgroundDescription.layer.insertSublayer(gradient, at: 0)
    }

    private func setupConstraints() {
        bacgroundDescriptionConstraints()
        descriptionLabelConstraints()
    }

    private func bacgroundDescriptionConstraints() {
        bacgroundDescription.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        bacgroundDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bacgroundDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bacgroundDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    private func descriptionLabelConstraints() {
        descriptionLabel.topAnchor.constraint(equalTo: bacgroundDescription.topAnchor, constant: 27).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: bacgroundDescription.leadingAnchor, constant: 27)
            .isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: bacgroundDescription.trailingAnchor, constant: -27)
            .isActive = true
    }
}
