// DetailsRecipesData+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

@objc(DetailsRecipesData)
/// Ячейки
public final class DetailsRecipesData: NSManagedObject {}

/// Расширение ячейка
public extension DetailsRecipesData {
    @NSManaged var label: String
    @NSManaged var totalTime: Int
    @NSManaged var calories: Int
    @NSManaged var images: String
    @NSManaged var totalWeight: Int
    @NSManaged var ingridientLines: String
}

extension DetailsRecipesData: Identifiable {}
