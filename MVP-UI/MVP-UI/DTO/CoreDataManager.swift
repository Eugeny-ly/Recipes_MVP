// CoreDataManager.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import UIKit

/// Протокол для работы с кор датоой
protocol CoreDataManagerProtocol: AnyObject {
    /// Сохранение в базу данных
    func createRecipe(recipe: RecipeCommonInfo, dishTitle: DishType)
    /// Запрос в базу данных  на сохранение рецептов
    func fetchRecipe(dishTitle: DishType) -> [RecipeCommonInfo]
    /// Cохранение деталей рецепта в базу данных
    func createDetailRecipes(detailRecipesDTO: RecipeDetail)
    /// Запрос в базу данных на детали рецепта
    func fetchDetail(name: String) -> RecipeDetail?
}

/// Cоздание обновления удаление
public final class CoreDataManager: CoreDataManagerProtocol {
    // MARK: - Constants

    private enum Constants {
        static let recipeDateEntity = Local.CoreData.recipeDateEntity
        static let detailRecipeDateEntity = Local.CoreData.detailRecipeDateEntity
    }

    // MARK: - Private Properties

    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    }

    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }

    // MARK: - Public Methods

    func createRecipe(recipe: RecipeCommonInfo, dishTitle: DishType) {
        guard let recipeEntityDescription = NSEntityDescription.entity(
            forEntityName: Constants.recipeDateEntity,
            in: context
        )
        else { return }
        let recipeData = RecipeData(entity: recipeEntityDescription, insertInto: context)
        recipeData.dishTitle = dishTitle.discription
        recipeData.label = recipe.label
        recipeData.calories = Int64(recipe.calories)
        recipeData.image = recipe.image
        recipeData.totaltime = recipe.totaltime
        recipeData.uri = recipe.uri
        appDelegate.saveContext()
    }

    func fetchRecipe(dishTitle: DishType) -> [RecipeCommonInfo] {
        let fetchRequest: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "dishTitle == %@", dishTitle.discription)
        var recipesDTO: [RecipeCommonInfo] = []
        do {
            let recipes = try context.fetch(fetchRequest)
            for item in recipes {
                let recipe = RecipeCommonInfo(dto: RecipeDTO(
                    image: item.image ?? "",
                    label: item.label ?? "",
                    totalTime: item.totaltime,
                    calories: Double(item.calories),
                    uri: item.uri ?? ""
                ))
                recipesDTO.append(recipe)
            }
            return recipesDTO
        } catch {
            return []
        }
    }

    func createDetailRecipes(detailRecipesDTO: RecipeDetail) {
        guard let detailEntityDiscriptions = NSEntityDescription.entity(
            forEntityName: Constants.detailRecipeDateEntity,
            in: context
        )
        else { return }
        let detailRecipes = DetailsRecipesData(entity: detailEntityDiscriptions, insertInto: context)
        detailRecipes.label = detailRecipesDTO.label
        detailRecipes.totalTime = Int64(detailRecipesDTO.totalTime)
        detailRecipes.calories = Int64(detailRecipesDTO.calories)
        detailRecipes.image = detailRecipesDTO.images
        detailRecipes.totalWeight = Int64(detailRecipesDTO.totalWeight)
        detailRecipes.ingridientLines = detailRecipesDTO.ingridientLines.first
        detailRecipes.totalNutrients?.calories = detailRecipesDTO.totalNutrients.calories.quantity
        detailRecipes.totalNutrients?.carbohydrates = detailRecipesDTO.totalNutrients.chocdf.quantity
        detailRecipes.totalNutrients?.fat = detailRecipesDTO.totalNutrients.fat.quantity
        detailRecipes.totalNutrients?.protein = detailRecipesDTO.totalNutrients.protein.quantity
        detailRecipes.ingridientLines = detailRecipesDTO.ingridientLines.joined(separator: ",")
        appDelegate.saveContext()
    }

    func fetchDetail(name: String) -> RecipeDetail? {
        let fetchDetail: NSFetchRequest<DetailsRecipesData> = DetailsRecipesData.fetchRequest()
        fetchDetail.predicate = NSPredicate(format: "label == %@", name)
        do {
            let detailRecipe = try? context.fetch(fetchDetail)
            let firstDetailRecipe = detailRecipe?.first
            let detail = RecipeDetail(dto: DetailDTO(
                label: firstDetailRecipe?.label ?? "",
                totalTime: Int(firstDetailRecipe?.totalTime ?? 0),
                calories: Double(firstDetailRecipe?.calories ?? 0),
                images: nil,
                totalWeight: Double(firstDetailRecipe?.totalWeight ?? 0),
                totalNutrients: TotalNutrientsDTO(
                    calories: TotalDTO(
                        quantity: firstDetailRecipe?.totalNutrients?
                            .calories ?? 0
                    ),
                    fat: TotalDTO(
                        quantity: firstDetailRecipe?.totalNutrients?
                            .fat ?? 0
                    ),
                    protein: TotalDTO(
                        quantity: firstDetailRecipe?.totalNutrients?
                            .protein ?? 0
                    ),
                    chocdf: TotalDTO(
                        quantity: firstDetailRecipe?.totalNutrients?
                            .carbohydrates ?? 0
                    )
                ),
                ingredientLines: firstDetailRecipe?.ingridientLines?.components(separatedBy: ",") ?? []
            ))

            return detail
        }
    }
}
