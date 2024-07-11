// RecipiesViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Ячейка категорий рецептов
final class RecipiesViewCell: UICollectionViewCell {
    // MARK: - Constants

    enum Constants {
        static let valueCornerRadius: CGFloat = 18
        static let fontVerdana = "Verdana"
    }

    // MARK: - Public Properties

    static let identifier = NSStringFromClass(RecipiesViewCell.self)
    var categoryPushHandler: VoidHandler?

    // MARK: - Private Properties

    private var modelCategory: Category?
    private let storage = Storage()
    private let logger = Logger()

    // MARK: - Visual Components

    private lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.valueCornerRadius
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(pushCategory), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var nameCategoryLabel: UILabel = {
        let label = UILabel()
        label.text = modelCategory?.categoryTitle.rawValue
        label.textColor = .white
        label.backgroundColor = .backgroundNameCategory
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        label.clipsToBounds = true
        label.font = UIFont(name: Constants.fontVerdana, size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)
        createContentView()
        addSubview()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createContentView()
        addSubview()
        setupConstraints()
    }

    // MARK: - Public Methods

    func configure(model: Category) {
        modelCategory = model
        let image = UIImage(named: model.avatarImageName)
        categoryButton.setImage(image, for: .normal)
        nameCategoryLabel.text = model.categoryTitle.rawValue
    }

    // MARK: - Private Methods

    private func createContentView() {
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOffset = CGSize(width: 5, height: 6)
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.4
    }

    private func addSubview() {
        contentView.addSubview(categoryButton)
        categoryButton.addSubview(nameCategoryLabel)
    }

    @objc private func pushCategory() {
        categoryPushHandler?()

        if let categoryTitle = modelCategory?.categoryTitle, let logURL = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first?.appendingPathComponent("log.txt") {
            let logAction = LogAction.userOpenRecipeScene(categoryTitle.rawValue)
            logAction.log(fileURL: logURL)

            do {
                let logContent = try String(contentsOf: logURL)
            } catch {}
        } else {}
    }
}

// MARK: - RecipiesViewCell + Constraints

private extension RecipiesViewCell {
    func setupConstraints() {
        setupCategoryButtonConstraints()
        setupNameCategoryConstraints()
    }

    func setupCategoryButtonConstraints() {
        categoryButton.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        categoryButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        categoryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        categoryButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    func setupNameCategoryConstraints() {
        nameCategoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        nameCategoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        nameCategoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        nameCategoryLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width / 5).isActive = true
    }
}
