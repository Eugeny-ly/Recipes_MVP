// DetailsInfoCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка КБЖУ блюда
final class DetailsInfoCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let fontVerdana = "Verdana"
        static let titleEnercKcal = "Enerc kcal"
        static let titleCarbohydrates = "Carbohydrates"
        static let titleFats = "Fats"
        static let titleProteins = "Proteins"
        static let defualtValue = "no Title"
    }

    // MARK: - Visual Components

    private lazy var firstBackgroundElements = makeBackgroundElementsImageView()
    private lazy var secondBackgroundElements = makeBackgroundElementsImageView()
    private lazy var thirdBackgroundElements = makeBackgroundElementsImageView()
    private lazy var fourthBackgroundElements = makeBackgroundElementsImageView()

    private lazy var enercKcalLabel = makeNutrientsLabel(title: Constants.titleEnercKcal, color: .white)
    private lazy var carbohydratesLabel = makeNutrientsLabel(title: Constants.titleCarbohydrates, color: .white)
    private lazy var fatsLabel = makeNutrientsLabel(title: Constants.titleFats, color: .white)
    private lazy var proteinsLabel = makeNutrientsLabel(title: Constants.titleProteins, color: .white)

    private lazy var enercKcalVlaueLabel = makeNutrientsLabel(color: .black)
    private lazy var carbohydratesVlaueLabel = makeNutrientsLabel(color: .black)
    private lazy var fatsVlaueLabel = makeNutrientsLabel(color: .black)
    private lazy var proteinsVlaueLabel = makeNutrientsLabel(color: .black)

    // MARK: - Public Properties

    static let identifier = NSStringFromClass(DetailsInfoCell.self)

    private lazy var backgroundStackView = UIStackView(
        arrangedsSubviews: [
            firstBackgroundElements,
            secondBackgroundElements,
            thirdBackgroundElements,
            fourthBackgroundElements
        ],
        axis: .horizontal,
        spacing: 10
    )
    private lazy var nutrientsTitleStackView = UIStackView(
        arrangedsSubviews: [
            enercKcalLabel,
            carbohydratesLabel,
            fatsLabel,
            proteinsLabel
        ],
        axis: .horizontal,
        spacing: 15
    )

    private lazy var nutrientsValuesStackView = UIStackView(
        arrangedsSubviews: [
            enercKcalVlaueLabel,
            carbohydratesVlaueLabel,
            fatsVlaueLabel,
            proteinsVlaueLabel
        ],
        axis: .horizontal,
        spacing: 15
    )

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

    // MARK: - Public Methods

    func configure(info: RecipeDetail) {
        enercKcalVlaueLabel.text = String(Int(info.totalNutrients.calories.quantity))
        carbohydratesVlaueLabel.text = String(Int(info.totalNutrients.chocdf.quantity))
        fatsVlaueLabel.text = String(Int(info.totalNutrients.fat.quantity))
        proteinsVlaueLabel.text = String(Int(info.totalNutrients.protein.quantity))
    }

    // MARK: - Private Methods

    private func makeBackgroundElementsImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = .backgroundCbgu
        imageView.tintColor = UIColor.selectedIconTabBar
        imageView.widthAnchor.constraint(equalToConstant: 78).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 53).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

    private func makeNutrientsLabel(title: String? = nil, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = title ?? Constants.defualtValue
        label.font = UIFont(name: Constants.fontVerdana, size: 10)
        label.textColor = color
        label.textAlignment = .center
        label.widthAnchor.constraint(equalToConstant: 74).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func setupViews() {
        contentView.addSubview(backgroundStackView)
        backgroundStackView.addSubview(nutrientsTitleStackView)
        backgroundStackView.addSubview(nutrientsValuesStackView)
    }

    private func setupConstraints() {
        backgroundStackViewConstraints()
        nutrientsTitleStackViewConstraints()
        nutrientsValuesStackViewConstraints()
    }

    private func backgroundStackViewConstraints() {
        backgroundStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }

    private func nutrientsTitleStackViewConstraints() {
        nutrientsTitleStackView.centerXAnchor.constraint(equalTo: backgroundStackView.centerXAnchor).isActive = true
        nutrientsTitleStackView.topAnchor.constraint(equalTo: backgroundStackView.topAnchor)
            .isActive = true
        nutrientsTitleStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func nutrientsValuesStackViewConstraints() {
        nutrientsValuesStackView.centerXAnchor.constraint(equalTo: backgroundStackView.centerXAnchor).isActive = true
        nutrientsValuesStackView.bottomAnchor.constraint(equalTo: backgroundStackView.bottomAnchor)
            .isActive = true
        nutrientsValuesStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
