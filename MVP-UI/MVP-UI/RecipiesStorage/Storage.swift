// Storage.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Моковые данные
final class Storage {
    // MARK: - Public Properties

    var fish: [Recipe] = [
        Recipe(
            avatarRecipie: "fish1",
            titleRecipies: "Simple Fish And Corn",
            cookingTimeTitle: 60,
            caloriesTitle: 274,
            nutrientsValue: ["1322 kcal", "10,78 g", "10,00 g", "97,30 g"],
            recipeDescriptionTitle: "1/2 to 2 fish heads, depending on size, about 5 pounds total\n" +
                "2 tablespoons vegetable oil\n" +
                "1/4 cup red or green thai curry paste\n" +
                "3 tablespoons fish sauce or anchovy sauce\n" +
                "1 tablespoon sugar\n" +
                "1 can coconut milk, about 12 ounces\n" +
                "3 medium size asian eggplants, cut int 1 inch rounds\n" +
                "Handful of bird's eye chilies\n" +
                "1/2 cup thai basil leaves\n" +
                "Juice of 3 limes\n" +
                "1/2 to 2 fish heads, depending on size, about 5 pounds total\n" +
                "2 tablespoons vegetable oil\n" +
                "1/4 cup red or green thai curry paste\n" +
                "3 tablespoons fish sauce or anchovy sauce\n" +
                "1 tablespoon sugar\n" +
                "1 can coconut milk, about 12 ounces\n" +
                "3 medium size asian eggplants, cut int 1 inch rounds\n" +
                "Handful of bird's eye chilies\n" +
                "1/2 cup thai basil leaves\n" +
                "Juice of 3 limes\n" +
                "1/2 to 2 fish heads, depending on size, about 5 pounds total\n" +
                "2 tablespoons vegetable oil\n" +
                "1/4 cup red or green thai curry paste\n" +
                "3 tablespoons fish sauce or anchovy sauce\n" +
                "1 tablespoon sugar\n" +
                "1 can coconut milk, about 12 ounces\n" +
                "3 medium size asian eggplants, cut int 1 inch rounds\n" +
                "Handful of bird's eye chilies\n" +
                "1/2 cup thai basil leaves\n" +
                "Juice of 3 limes",
            portionWeight: "793 g"
        ),
        Recipe(
            avatarRecipie: "fish2",
            titleRecipies: "Baked Fish with Lemon Herb Sauce",
            cookingTimeTitle: 90,
            caloriesTitle: 616,
            nutrientsValue: ["1322 kcal", "10,78 g", "10,00 g", "97,30 g"],
            recipeDescriptionTitle: "",
            portionWeight: "191 g"
        ),
        Recipe(
            avatarRecipie: "fish3",
            titleRecipies: "Lemon and Chilli Fish Burrito",
            cookingTimeTitle: 90,
            caloriesTitle: 226,
            nutrientsValue: ["1322 kcal", "10,78 g", "10,00 g", "97,30 g"],
            recipeDescriptionTitle: "",
            portionWeight: "715 g"
        ),
        Recipe(
            avatarRecipie: "fish4",
            titleRecipies: "Fast Roast Fish & Show Peas Recipes",
            cookingTimeTitle: 80,
            caloriesTitle: 94,
            nutrientsValue: ["1322 kcal", "10,78 g", "10,00 g", "97,30 g"],
            recipeDescriptionTitle: "",
            portionWeight: "890 g"
        ),
        Recipe(
            avatarRecipie: "fish5",
            titleRecipies: "Salmon with Cantaloupe and Fried Shallots",
            cookingTimeTitle: 100,
            caloriesTitle: 410,
            nutrientsValue: ["1322 kcal", "10,78 g", "10,00 g", "97,30 g"],
            recipeDescriptionTitle: "",
            portionWeight: "555 g"
        ),
        Recipe(
            avatarRecipie: "fish6",
            titleRecipies: "Chilli and Tomato Fish",
            cookingTimeTitle: 100,
            caloriesTitle: 174,
            nutrientsValue: ["1322 kcal", "10,78 g", "10,00 g", "97,30 g"],
            recipeDescriptionTitle: "",
            portionWeight: "895 g"
        )
    ]

    lazy var category: [Category] = [
        .init(avatarImageName: "salad", categoryTitle: .salad, sizeCell: .medium, recepies: []),
        .init(avatarImageName: "soup", categoryTitle: .soup, sizeCell: .medium, recepies: []),
        .init(
            avatarImageName: "chicken",
            categoryTitle: .chicken,
            sizeCell: .big,
            recepies: []
        ),
        .init(avatarImageName: "meat", categoryTitle: .meat, sizeCell: .small, recepies: []),
        .init(avatarImageName: "fish", categoryTitle: .fish, sizeCell: .small, recepies: fish),
        .init(
            avatarImageName: "side dish",
            categoryTitle: .sideDish,
            sizeCell: .small,
            recepies: []
        ),
        .init(avatarImageName: "drinks", categoryTitle: .drinks, sizeCell: .big, recepies: []),
        .init(
            avatarImageName: "pancakes",
            categoryTitle: .pancake,
            sizeCell: .medium,
            recepies: []
        ),
        .init(
            avatarImageName: "desserts",
            categoryTitle: .desserts,
            sizeCell: .medium,
            recepies: []
        )
    ]
}
