// RecipesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол презентера экрана категорий
protocol CategoryViewInputProtocol: AnyObject {
    /// Метод для обновления таблицы
    func updateData(category: Storage)
    /// Меняем состояние шимера
    func changeShimerState()
}

/// Экран с рецептами
final class RecipesViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let titleRecipesItem = Local.Recipes.titleRecipesItem
        static let minimumLineSpacing: CGFloat = 15
        static let widthSmallCell: CGFloat = 40
        static let heightSmallCell: CGFloat = 40
        static let widthMediumCell: CGFloat = 30
        static let heightMediumCell: CGFloat = 30
        static let basicSizeCell: CGFloat = 50
        static let timeChangeShimerState: CGFloat = 2
    }

    // MARK: - Public Properties

    var presenter: RecipesPresenter?
    var storage: Storage?

    // MARK: - Private Properties

    private var stateShimer = StateShimer.loading
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private let layout = UICollectionViewFlowLayout()
    private let categoryLayer = CAGradientLayer()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.requestDataCategory()
        addSubview()
        makeCollectionView()
        makeNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }

    // MARK: - Private Methods

    private func addSubview() {
        presenter?.changeShimerState()
        view.addSubview(collectionView)
    }

    private func makeCollectionView() {
        collectionView.register(RecipiesViewCell.self, forCellWithReuseIdentifier: RecipiesViewCell.identifier)
        collectionView.register(
            ShimerCollectionViewCell.self,
            forCellWithReuseIdentifier: ShimerCollectionViewCell.identifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func makeNavigationBar() {
        title = Constants.titleRecipesItem
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupConstraints() {
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: - Extension + UICollectionViewDataSource

extension RecipesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        storage?.category.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch stateShimer {
        case .loading:
            guard let cellShimer = collectionView.dequeueReusableCell(
                withReuseIdentifier: ShimerCollectionViewCell.identifier,
                for: indexPath
            ) as? ShimerCollectionViewCell else { return UICollectionViewCell() }
            return cellShimer
        case .done:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RecipiesViewCell.identifier,
                for: indexPath
            ) as? RecipiesViewCell else { return UICollectionViewCell() }
            guard let storage = storage else { return cell }
            cell.configure(model: storage.category[indexPath.item])
            cell.categoryPushHandler = {
                self.presenter?.tappedOnCell(type: storage.category[indexPath.item])
            }
            return cell
        }
    }
}

// MARK: - Extension + UICollectionViewDelegateFlowLayout

extension RecipesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let storage = storage
        else { return CGSize(width: Constants.basicSizeCell, height: Constants.basicSizeCell) }
        let size = storage.category[indexPath.item].sizeCell
        switch size {
        case .small:
            let small = CGSize(
                width: (UIScreen.main.bounds.width - Constants.widthSmallCell) / 3,
                height: (UIScreen.main.bounds.width - Constants.heightSmallCell) / 3
            )
            return small
        case .medium:
            let medium = CGSize(
                width: (UIScreen.main.bounds.width - Constants.widthMediumCell) / 2,
                height: (UIScreen.main.bounds.width - Constants.heightMediumCell) / 2
            )
            return medium
        case .big:
            let big = CGSize(width: 250, height: 250)
            return big
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constants.minimumLineSpacing
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}

// MARK: - Extension + CategoryViewInputProtocol

extension RecipesViewController: CategoryViewInputProtocol {
    func changeShimerState() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.timeChangeShimerState) {
            self.stateShimer = .done
            self.collectionView.reloadData()
        }
    }

    func updateData(category: Storage) {
        storage = category
        collectionView.reloadData()
    }
}
