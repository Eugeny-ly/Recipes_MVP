// Strings+Generated.swift
// Copyright © RoadMap. All rights reserved.

// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
enum Local {
    /// Email Address
    static let emailAddress = Local.tr("Localizable", "Email Address", fallback: "Email Address")
    /// Enter Email Address
    static let enterEmailAddress = Local.tr("Localizable", "Enter Email Address", fallback: "Enter Email Address")
    /// Enter Password
    static let enterPassword = Local.tr("Localizable", "Enter Password", fallback: "Enter Password")
    /// Incorrect format
    static let incorrectFormat = Local.tr("Localizable", "Incorrect format", fallback: "Incorrect format")
    /// Localizable.strings
    ///   MVP-UI
    ///
    ///   Created by Vakil on 29.03.2024.
    static let login = Local.tr("Localizable", "Login", fallback: "Login")
    /// Password
    static let password = Local.tr("Localizable", "Password", fallback: "Password")
    /// Please check the accuracy of the entered credentials
    static let pleaseCheckTheAccuracyOfTheEnteredCredentials = Local.tr(
        "Localizable",
        "Please check the accuracy of the entered credentials.",
        fallback: "Please check the accuracy of the entered credentials"
    )
    /// You entered the wrong password
    static let youEnteredTheWrongPassword = Local.tr(
        "Localizable",
        "You entered the wrong password",
        fallback: "You entered the wrong password"
    )
    enum CoreData {
        /// DetailsRecipesData
        static let detailRecipeDateEntity = Local.tr(
            "Localizable",
            "coreData.detailRecipeDateEntity",
            fallback: "DetailsRecipesData"
        )
        /// RecipeData
        static let recipeDateEntity = Local.tr("Localizable", "coreData.recipeDateEntity", fallback: "RecipeData")
    }

    enum Map {
        /// You can get gifts and discounts from our partners
        static let title = Local.tr(
            "Localizable",
            "map.title",
            fallback: "You can get gifts and discounts from our partners"
        )
    }

    enum Recipes {
        /// Recipes
        static let titleRecipesItem = Local.tr("Localizable", "recipes.titleRecipesItem", fallback: "Recipes")
    }
}

// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Local {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle: Bundle = {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        return Bundle(for: BundleToken.self)
        #endif
    }()
}

// swiftlint:enable convenience_type
