// NavigationTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Ячеки бонус, полиси, выход
final class NavigationTableViewCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static var fontVerdana = "Verdana"
    }

    // MARK: - Visual Components

    private var iconCellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var nameTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.fontVerdana, size: 18)
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var arrowIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .arrow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Public Properties

    static let identifier = NSStringFromClass(NavigationTableViewCell.self)

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addViews()
        setupConstraints()
    }

    // MARK: - Public Methods

    func configure(with info: ProfileNavigationCellSource) {
        iconCellImageView.image = UIImage(named: info.shortcutCell)
        nameTextLabel.text = info.nameCell
        selectionStyle = .none
    }

    // MARK: - Private Methods

    private func addViews() {
        contentView.addSubview(nameTextLabel)
        contentView.addSubview(arrowIconImageView)
        contentView.addSubview(iconCellImageView)
    }

    private func setupConstraints() {
        setupArrowIconConstraints()
        setupNameTextConstraints()
        setupIconCellConstraints()
    }

    private func setupIconCellConstraints() {
        iconCellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        iconCellImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        iconCellImageView.widthAnchor.constraint(equalToConstant: 23).isActive = true
        iconCellImageView.heightAnchor.constraint(equalToConstant: 23).isActive = true
    }

    private func setupNameTextConstraints() {
        nameTextLabel.leadingAnchor.constraint(equalTo: iconCellImageView.trailingAnchor, constant: 15).isActive = true
        nameTextLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }

    private func setupArrowIconConstraints() {
        arrowIconImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        arrowIconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        arrowIconImageView.widthAnchor.constraint(equalToConstant: 17).isActive = true
        arrowIconImageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
    }
}
