// RecipeData+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

///
@objc(RecipeData)
public class RecipeData: NSManagedObject {}
///
public extension RecipeData {
    @NSManaged var image: String?
    @NSManaged var label: String?
    @NSManaged var totaltime: Double
    @NSManaged var calories: Int64
    @NSManaged var uri: String?
    @NSManaged var resipeDetails: DetailsRecipesData?
}

extension RecipeData: Identifiable {}
