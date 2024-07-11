// HeaderTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Ячейка шапки
final class HeaderTableViewCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static var fontVerdanaBold = "Verdana-Bold"
        static let defaultAvatar = UIImage.imageProfile
    }

    // MARK: - Visual Components

    private lazy var avatarProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(changeIcon(gestureRecognizer:)))
        imageView.addGestureRecognizer(imageTap)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.fontVerdanaBold, size: 25)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var editingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.editingIcon, for: .normal)
        button.tintColor = UIColor.blackColor(alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editingButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Public Properties

    var editingButtonHandler: VoidHandler?
    var changeImageHandler: VoidHandler?

    static let identifier = NSStringFromClass(HeaderTableViewCell.self)

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

    func configure(with info: ProfileHeaderCellSource) {
        userNameLabel.text = info.userName
        selectionStyle = .none
        if let avatar = info.avatarImageName {
            avatarProfileImageView.image = UIImage(data: avatar)
        } else {
            avatarProfileImageView.image = Constants.defaultAvatar
        }
    }

    // MARK: - Private Methods

    private func addViews() {
        contentView.addSubview(avatarProfileImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(editingButton)
    }

    private func setupConstraints() {
        setupAvatarProfileConstrints()
        setupUserNameConstants()
        setupEditingButtonConstants()
    }

    private func setupAvatarProfileConstrints() {
        avatarProfileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 36).isActive = true
        avatarProfileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        avatarProfileImageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        avatarProfileImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
    }

    private func setupUserNameConstants() {
        userNameLabel.topAnchor.constraint(equalTo: avatarProfileImageView.bottomAnchor, constant: 15).isActive = true
        userNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        userNameLabel.widthAnchor.constraint(equalToConstant: 256).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func setupEditingButtonConstants() {
        editingButton.leftAnchor.constraint(equalTo: userNameLabel.rightAnchor).isActive = true
        editingButton.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor).isActive = true
        editingButton.widthAnchor.constraint(equalToConstant: 18).isActive = true
        editingButton.heightAnchor.constraint(equalToConstant: 18).isActive = true
    }

    @objc private func editingButtonTapped() {
        editingButtonHandler?()
    }

    @objc private func changeIcon(gestureRecognizer: UITapGestureRecognizer) {
        changeImageHandler?()
    }
}
