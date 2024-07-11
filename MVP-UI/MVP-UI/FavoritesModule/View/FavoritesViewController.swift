// FavoritesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Экран с избранными
final class FavoritesViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let title = "Favorites"
        static let noFavoritesImage = UIImage.emptyView
        static let favoritesIdentefire = "CellIdentefire"
    }

    // MARK: - Public Properties

    var favoritesPresenter: FavoritesPresenter?
    var recipe: [RecipeCommonInfo]?

    // MARK: - Visual Components

    private let emptyFavoritesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.noFavoritesImage
        return imageView
    }()

    private lazy var favoritesTableView: UITableView = {
        let table = UITableView()
        table.register(RecipesCell.self, forCellReuseIdentifier: Constants.favoritesIdentefire)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        return table
    }()

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        favoritesPresenter?.emptyView()
        favoritesTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Private Methods

    private func configureUI() {
        makeNavigationBar()
    }

    private func makeNavigationBar() {
        title = Constants.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func makeTableFavorites() {
        view.addSubview(favoritesTableView)
        createFavoritesTableAnchor()
        emptyFavoritesImageView.removeFromSuperview()
    }

    private func addEmptyView() {
        view.addSubview(emptyFavoritesImageView)
        createEmptyFavoritesAnchor()
        favoritesTableView.removeFromSuperview()
    }
}

// MARK: - FavoritesViewController + Constraints

extension FavoritesViewController {
    private func createEmptyFavoritesAnchor() {
        emptyFavoritesImageView.translatesAutoresizingMaskIntoConstraints = false
        emptyFavoritesImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        emptyFavoritesImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyFavoritesImageView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor).isActive = true
        emptyFavoritesImageView.heightAnchor.constraint(equalToConstant: 132).isActive = true
    }

    private func createFavoritesTableAnchor() {
        favoritesTableView.translatesAutoresizingMaskIntoConstraints = false
        favoritesTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        favoritesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        favoritesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        favoritesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: - UITableViewDelegate

extension FavoritesViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {}
}

// MARK: - UITableViewDataSource

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipe = recipe?[indexPath.row] else { return }
        favoritesPresenter?.pushDetailFavoritesViewController(recipe: recipe)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        125
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipe?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.favoritesIdentefire,
            for: indexPath
        ) as? RecipesCell {
            guard let recipe = recipe else { return cell }
            cell.configure(with: recipe[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension FavoritesViewController: FavoritesViewProtocol {
    func makeTable(favorites: [RecipeCommonInfo]) {
        recipe = favorites
        makeTableFavorites()
    }

    func makeTable() {
        makeTableFavorites()
    }

    func emptyFaforites() {
        addEmptyView()
    }
}
