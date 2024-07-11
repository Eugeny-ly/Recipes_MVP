// RecipesListViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Табличное представлене с рецептами
final class RecipesListViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let cellIdendefire = "CellRecipes"
        static let backBarButtonImage = UIImage(systemName: "arrow.backward")
        static let filterIconImage = UIImage(named: "filterIcon")
        static let titleNavigation = "Fish"
        static let serchPlaceholder = "Search recipes"
        static let caloriesButtonTitle = "Calories"
        static let timeButtonTitle = "Time"
        static let valueToStartSearch: CGFloat = 2
        static let changeShimerState: CGFloat = 2
        static let valueSearchText = 2
        static let emptyDataImage = UIImage.emptyViewData
        static let errorServiceImage = UIImage.errorService
    }

    // MARK: - Visual Components

    private let errorServiceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.errorServiceImage
        return imageView
    }()

    private let emptyDataImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.emptyDataImage
        return imageView
    }()

    private lazy var recipesTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.register(RecipesCell.self, forCellReuseIdentifier: Constants.cellIdendefire)
        table.showsVerticalScrollIndicator = false
        return table
    }()

    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = Constants.serchPlaceholder
        search.backgroundImage = UIImage()
        search.sizeToFit()
        search.delegate = self
        return search
    }()

    private lazy var refreshControll: UIRefreshControl = {
        let refreshControll = UIRefreshControl()
        refreshControll.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        return refreshControll
    }()

    let caloriesButton = UIButton()
    let timeButton = UIButton()

    // MARK: - Public Properties

    var recipePresenter: RecipePresenter?

    // MARK: - Private Properties

    private var recipes: [RecipeCommonInfo]?
    private var searchRecipes: [RecipeCommonInfo] = []

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        navigationController?.navigationBar.tintColor = .black
        if let logURL = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first?.appendingPathComponent("log.txt") {
        } else {}
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipePresenter?.getRecipe()
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(recipesTableView)
        recipesTableView.addSubview(refreshControll)
        makeFilterButton(button: caloriesButton, title: Constants.caloriesButtonTitle)
        makeFilterButton(button: timeButton, title: Constants.timeButtonTitle)
        makeAnchor()
        searchRecipes = recipes ?? []
    }

    private func configureNavigation(type: DishType) {
        navigationController?.navigationBar.tintColor = .black
        let back = UIBarButtonItem(
            image: Constants.backBarButtonImage,
            style: .done,
            target: self,
            action: #selector(dissmiss)
        )
        let backTitle = UIBarButtonItem(
            title: type.header,
            style: .done,
            target: self,
            action: #selector(dissmiss)
        )
        let font = UIFont.boldSystemFont(ofSize: 26.0)
        let textAttributes: [NSAttributedString.Key: Any] = [.font: font]
        backTitle.setTitleTextAttributes(textAttributes, for: .normal)
        navigationItem.leftBarButtonItems = [back, backTitle]
    }

    private func makeFilterButton(button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setImage(Constants.filterIconImage, for: .normal)
        button.backgroundColor = UIColor(red: 242 / 255, green: 245 / 255, blue: 250 / 255, alpha: 1.0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 10)
        timeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 10)
        caloriesButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 10)
        timeButton.addTarget(self, action: #selector(timeButtonTapped), for: .touchUpInside)
        caloriesButton.addTarget(self, action: #selector(caloriesButtonTapped), for: .touchUpInside)
        view.addSubview(button)
    }

    private func addEmptyView() {
        view.addSubview(emptyDataImageView)
        setupEmptyDataImageConstraints()
        recipesTableView.removeFromSuperview()
    }

    private func addErrorServiceView() {
        view.addSubview(errorServiceImageView)
        setupErrorServiceImageConstraints()
        recipesTableView.removeFromSuperview()
    }

    private func makeAnchor() {
        makeAnchorsSearchBar()
        setupAnchorsCaloriesButton()
        setupAnchorsTimeButton()
        makeTableViewAnchor()
    }

    @objc private func caloriesButtonTapped() {
//        recipePresenter?.buttonCaloriesChange(category: recipes?.recepies ?? [])
    }

    @objc private func timeButtonTapped() {
//        recipePresenter?.buttonTimeChange(category: recipes?.recepies ?? [])
    }

    @objc private func dissmiss() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func refreshTable() {
        recipePresenter?.getRecipe()
    }
}

// MARK: - Extension + Constraints

extension RecipesListViewController {
    private func makeAnchorsSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 96).isActive = true
        searchBar.widthAnchor.constraint(equalToConstant: 335).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }

    private func makeTableViewAnchor() {
        recipesTableView.translatesAutoresizingMaskIntoConstraints = false
        recipesTableView.topAnchor.constraint(equalTo: timeButton.bottomAnchor, constant: 10).isActive = true
        recipesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        recipesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        recipesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func setupAnchorsCaloriesButton() {
        caloriesButton.translatesAutoresizingMaskIntoConstraints = false
        caloriesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        caloriesButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20).isActive = true
        caloriesButton.widthAnchor.constraint(equalToConstant: 112).isActive = true
        caloriesButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }

    private func setupAnchorsTimeButton() {
        timeButton.translatesAutoresizingMaskIntoConstraints = false
        timeButton.leadingAnchor.constraint(equalTo: caloriesButton.trailingAnchor, constant: 11).isActive = true
        timeButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20).isActive = true
        timeButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        timeButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }

    private func setupEmptyDataImageConstraints() {
        emptyDataImageView.translatesAutoresizingMaskIntoConstraints = false
        emptyDataImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        emptyDataImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyDataImageView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor).isActive = true
        emptyDataImageView.heightAnchor.constraint(equalToConstant: 85).isActive = true
    }

    private func setupErrorServiceImageConstraints() {
        errorServiceImageView.translatesAutoresizingMaskIntoConstraints = false
        errorServiceImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        errorServiceImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorServiceImageView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor).isActive = true
        errorServiceImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
}

// MARK: - Extension + UITableViewDelegate

extension RecipesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipe = recipes?[indexPath.row] else { return }

        if let logURL = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first?.appendingPathComponent("log.txt") {
            LogAction.userOpenRecipe(recipe.label).log(fileURL: logURL)
            do {
                let logContent = try String(contentsOf: logURL)
            } catch {}
        }

        recipePresenter?.tappedOnCell(recipe: recipe)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        125
    }
}

// MARK: - Extension + UITableViewDataSource

extension RecipesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch recipePresenter?.state {
        case .loading:
            10
        case .data:
            recipes?.count ?? 0
        case .noData, .error, .none:
            0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch recipePresenter?.state {
        case .loading:
            return ShimerViewCell()
        case .data:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.cellIdendefire,
                for: indexPath
            ) as? RecipesCell
            else { return UITableViewCell() }
            guard let recipe = recipes?[indexPath.row] else { return cell }
            cell.configure(with: recipe)
            return cell
        case .noData:
            break
        case .error:
            break
        case .none:
            break
        }
        return UITableViewCell()
    }
}

// MARK: - Extension + RecipesViewProtocol

extension RecipesListViewController: RecipesViewProtocol {
    func getHeaderTitle(type: DishType) {
        configureNavigation(type: type)
    }

    func updateStateView() {
        switch recipePresenter?.state {
        case .loading, .data:
            recipesTableView.reloadData()
        case .noData:
            emptyData()
        case .error, .none:
            addErrorServiceView()
        }
    }

    func emptyData() {
        addEmptyView()
    }

    func errorData() {
        addErrorServiceView()
    }

    func buttonCaloriesState(color: String, image: String) {
        caloriesButton.backgroundColor = UIColor(named: color)
        caloriesButton.setTitleColor(.white, for: .normal)
        caloriesButton.setImage(UIImage(named: image), for: .normal)
        caloriesButton.setTitleColor(.black, for: .normal)
    }

    func buttonTimeState(color: String, image: String) {
        timeButton.backgroundColor = UIColor(named: color)
        timeButton.setTitleColor(.white, for: .normal)
        timeButton.setImage(UIImage(named: image), for: .normal)
        timeButton.setTitleColor(.black, for: .normal)
    }

    func sortedRecip(recipe: [Recipe]) {
        recipesTableView.reloadData()
    }

    func getRecipes(recipes: [RecipeCommonInfo]) {
        self.recipes = recipes
        searchRecipes = recipes
        recipesTableView.reloadData()
        refreshControll.endRefreshing()
    }
}

// MARK: - Extension + UISearchBarDelegate

extension RecipesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > Constants.valueSearchText {
            let searchFiltered = recipes?
                .filter { $0.label.prefix(searchText.count) == searchText }
            recipes = searchFiltered ?? []
            recipesTableView.reloadData()
        } else {
            recipes = searchRecipes
            recipesTableView.reloadData()
        }
    }
}
