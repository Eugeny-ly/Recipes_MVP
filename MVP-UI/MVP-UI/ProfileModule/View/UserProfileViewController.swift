// UserProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол презентера экрана профиля
protocol UserProfileViewInputProtocol: AnyObject {
    /// Метод для вызова алерта
    func showAlertChangeName()
    /// Метод для обновления таблицы
    func updateTable(profileTable: [ProfileItem])
    /// Метод для установки имени юзера
    func setTitleNameUser(name: String)
    ///  Метод для показа бонус-контролерра
    func showBonusView()
    /// Метод для показа политики конфиденциальности
    func showTermsPrivacyPolicy()
    /// Метод откритя карты
    func showCart()
}

/// Экран с информацией о пользователе
final class UserProfileViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let titleNotices = "Profile"
        static let nameRegisterCell = "Cell"
        static let alertTitle = "Change your name and surname"
        static let cancelAlertButton = "Cancel"
        static let placeholderAlert = "Name Surname"
        static let doneButton = "Ok"
        static let timer: CGFloat = 2
    }

    // MARK: - Visual Components

    private lazy var imagePicker = UIImagePickerController()
    private let tableView = UITableView(frame: .zero, style: .plain)

    // MARK: - Public Properties

    var presenter: UserProfilePresenterInputProtocol?

    // MARK: - Private Properties

    private var rowTypes: [ProfileItem]?
    private var termsPrivacyPolicyView: TermsPrivatePolicyView?
    private var visualEffectView: UIVisualEffectView?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        makeTableView()
        makeNavigation()
        makeTableView()
        presenter?.requestUser()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }

    // MARK: - Private Methods

    private func addSubview() {
        view.addSubview(tableView)
    }

    private func makeNavigation() {
        navigationItem.title = Constants.titleNotices
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func makeTableView() {
        tableView.register(HeaderTableViewCell.self, forCellReuseIdentifier: HeaderTableViewCell.identifier)
        tableView.register(NavigationTableViewCell.self, forCellReuseIdentifier: NavigationTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }

    private func setupConstraints() {
        setupTableViewConstraints()
    }

    private func setupTableViewConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func callImagePickerController() {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - UserProfileViewController + UITableViewDataSource

extension UserProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        rowTypes?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowsType = rowTypes?[section]
        switch rowsType {
        case .header:
            return 1
        case .navigation:
            return 4
        case .none:
            return 3
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rowsType = rowTypes else { return UITableViewCell() }
        switch rowsType[indexPath.section] {
        case let .header(header):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: HeaderTableViewCell.identifier,
                for: indexPath
            ) as? HeaderTableViewCell else { return UITableViewCell() }
            cell.configure(with: header)
            cell.editingButtonHandler = { [weak self] in
                self?.presenter?.actionAlert()
            }
            cell.changeImageHandler = callImagePickerController

            return cell

        case let .navigation(navigation):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: NavigationTableViewCell.identifier,
                for: indexPath
            ) as? NavigationTableViewCell else { return UITableViewCell() }
            cell.configure(with: navigation[indexPath.row])
            return cell
        }
    }
}

// MARK: - UserProfileViewController + UITableViewDelegate

extension UserProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cell = rowTypes?[indexPath.section] else { return 0 }
        switch cell {
        case .header:
            return 250
        case .navigation:
            return 60
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = rowTypes?[indexPath.section]
        switch item {
        case .header:
            break
        case .navigation:
            presenter?.tapSelectItem(index: indexPath.row)
        case .none:
            break
        }
    }
}

// MARK: - UserProfileViewController + UserProfileViewInputProtocol

extension UserProfileViewController: UserProfileViewInputProtocol {
    func showCart() {}

    func showTermsPrivacyPolicy() {
        termsPrivacyPolicyView = TermsPrivatePolicyView(frame: CGRect(
            x: 0,
            y: view.frame.height - 500,
            width: view.bounds.width,
            height: view.bounds.height
        ))
        visualEffectView = UIVisualEffectView(frame: view.frame)
        guard let visualEffectView = visualEffectView else { return }
        view.addSubview(visualEffectView)
        let blurAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1) {
            self.visualEffectView?.effect = UIBlurEffect(style: .extraLight)
        }
        blurAnimator.startAnimation()
        let connectedScenes = UIApplication.shared.connectedScenes
        let windowScene = connectedScenes.first as? UIWindowScene

        UIView.animate(withDuration: 2) {
            windowScene?.windows.last?.addSubview(self.termsPrivacyPolicyView ?? TermsPrivatePolicyView())
        }

        termsPrivacyPolicyView?.handler = { [weak self] in
            self?.visualEffectView?.isUserInteractionEnabled = false
            let blurAnimation = UIViewPropertyAnimator(duration: 1, dampingRatio: 1) {
                self?.visualEffectView?.effect = nil
            }
            blurAnimator.startAnimation()
            self?.visualEffectView?.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.timer) {
                self?.termsPrivacyPolicyView?.removeFromSuperview()
                visualEffectView.removeFromSuperview()
            }
        }
    }

    func showBonusView() {
        presenter?.showBonus()
    }

    func setTitleNameUser(name: String) {
        guard var currentRowsType = rowTypes else { return }

        if let headerIndex = currentRowsType.firstIndex(where: { item in
            if case .header = item {
                return true
            } else {
                return false
            }
        }) {
            if case var .header(data) = currentRowsType[headerIndex] {
                data.userName = name
                currentRowsType[headerIndex] = .header(data)
                rowTypes = currentRowsType
                tableView.reloadData()
            }
        }
    }

    func showAlertChangeName() {
        let alert = UIAlertController(title: Constants.alertTitle, message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: Constants.doneButton, style: .default) { _ in
            if let text = alert.textFields?.first?.text {
                self.presenter?.updateUserName(withName: text)
            }
        }

        let cancelAction = UIAlertAction(title: Constants.cancelAlertButton, style: .default)
        alert.addTextField { textField in
            textField.placeholder = Constants.placeholderAlert
        }
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

    func updateTable(profileTable: [ProfileItem]) {
        rowTypes = profileTable
        tableView.reloadData()
    }
}

// MARK: - UIImagePickerControllerDelegate

extension UserProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            presenter?.updateUserInfo(avatar: photo.pngData() ?? Data())
            tableView.reloadData()
            dismiss(animated: true, completion: nil)
        }
    }
}
