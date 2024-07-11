// UITesting.swift
// Copyright © RoadMap. All rights reserved.

@testable import MVP_UI
import XCTest

// swiftlint:disable all
final class UITesting: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        //  continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests
        // before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func checkStatic(textID: String, app: XCUIApplication) {
        guard app.staticTexts[textID].exists else {
            XCTFail("Нет текста \(textID)")
            return
        }
    }

    /// Тест раздела авторизации
    func testTextAutorization() {
        let app = XCUIApplication()
        app.launch()
        /// Проверка на наличие слова "Login"
        checkStatic(textID: "Login", app: app)
        /// Проверка на наличие слова "Email Address"
        checkStatic(textID: "Email Address", app: app)
        /// Проверка на наличие слова "Password"
        checkStatic(textID: "Password", app: app)
    }

    func testAutorization() {
        let validLogin = "Vaka@"
        let validPassword = "123456"
        let app = XCUIApplication()
        app.launch()
        let login = app.textFields["Enter Email Address"]
        XCTAssertTrue(login.exists)
        login.tap()
        login.typeText(validLogin)

        let enterPasswordSecureTextField = app.secureTextFields["Enter Password"]
        XCTAssertTrue(enterPasswordSecureTextField.exists)
        enterPasswordSecureTextField.tap()
        enterPasswordSecureTextField.typeText(validPassword)
        app.buttons["Login"].staticTexts["Login"].tap()
        testRecipesTable(app: app)
    }

    func testRecipesTable(app: XCUIApplication) {
        let cellElement = app.collectionViews.staticTexts["fish"]
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: cellElement, handler: nil)
        waitForExpectations(timeout: 8)
        XCTAssertTrue(cellElement.exists)
        cellElement.tap()
        let cellDetail = app.tables.cells
            .containing(
                .staticText,
                identifier: "Pressure-Cooker Octopus Recipe"
            )
        app.tables.cells
            .containing(
                .staticText,
                identifier: "Garlic Confit Recipe"
            ).children(matching: .other).element(boundBy: 1).swipeUp()
        cellDetail.children(matching: .other).element(boundBy: 1).tap()
    }

    func testProfile() throws {
        let validLogin = "Adm@"
        let validPassword = "123456"
        let app = XCUIApplication()
        app.launch()
        let login = app.textFields["Enter Email Address"]
        XCTAssertTrue(login.exists)
        login.tap()
        login.typeText(validLogin)

        let enterPasswordSecureTextField = app.secureTextFields["Enter Password"]
        XCTAssertTrue(enterPasswordSecureTextField.exists)
        enterPasswordSecureTextField.tap()
        enterPasswordSecureTextField.typeText(validPassword)
        app.buttons["Login"].staticTexts["Login"].tap()

        let profileBarItem = app.tabBars["Tab Bar"].buttons["Profile"]
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: profileBarItem, handler: nil)
        waitForExpectations(timeout: 5)

        // Проверяем, существует ли бар итем профиля
        XCTAssertTrue(profileBarItem.exists, "profileBarItem not found")
        profileBarItem.tap()

        let profileTable = app.tables

        // Проверяем, существует ли элемент с текстом "Bonuses" в таблице
        XCTAssertTrue(profileTable.staticTexts["Bonuses"].exists, "Bonuses label not found")
        profileTable.staticTexts["Bonuses"].tap()

        // Проверяем, существует ли кнопка с идентификатором "closeButton"
        XCTAssertTrue(app.buttons["closeButton"].exists, "Close button not found")
        app.buttons["closeButton"].tap()

        // Проверяем, существует ли ячейка с текстом "Bonuses"
        let bonusesCell = profileTable.cells.containing(.staticText, identifier: "Bonuses").element
        XCTAssertTrue(bonusesCell.exists, "Bonuses cell not found")
        bonusesCell.children(matching: .other).element.tap()

        // Проверяем, существует ли ячейка с текстом "Terms & Privacy Policy"
        let termsCell = profileTable.cells.containing(.staticText, identifier: "Terms & Privacy Policy").element
        XCTAssertTrue(termsCell.exists, "Terms & Privacy Policy cell not found")
        termsCell.tap()

        // Проверяем, существует ли кнопка закрытия "Terms & Privacy Policy"
        let closeButtonTerm = XCUIApplication().buttons["closeButton"]
        XCTAssertTrue(closeButtonTerm.exists, "closeButtonTerm not found")
        closeButtonTerm.tap()

        // Проверяем, существует ли кнопка редактирования в профиле
        let editingIcon = profileTable.cells.buttons["editingIcon"]
        XCTAssertTrue(editingIcon.exists, "editingIcon not found")
        editingIcon.tap()

        // Проверяем что аллерт существует
        var changeAlert = app.alerts["Change your name and surname"]
        XCTAssertTrue(changeAlert.exists, "editingIcon not found")

        // Проверяем что в алерте кнопка Ок существует
        let changeAlertOkButton = changeAlert.scrollViews.otherElements.buttons["Ok"]
        XCTAssertTrue(changeAlertOkButton.exists, "changeAlertOkButton not found")
        changeAlertOkButton.tap()

        editingIcon.tap()
        // Проверяем что аллерт существует
        changeAlert = app.alerts["Change your name and surname"]
        XCTAssertTrue(changeAlert.exists, "editingIcon not found")

        // Проверяем что в алерте кнопка Cancel существует
        let changeAlertCancelButton = changeAlert.scrollViews.otherElements.buttons["Cancel"]
        XCTAssertTrue(changeAlertCancelButton.exists, "changeAlertOkButton not found")
        changeAlertCancelButton.tap()
    }

    func testFavourites() throws {
        let validLogin = "Adm@"
        let validPassword = "123456"
        let app = XCUIApplication()
        app.launch()
        let login = app.textFields["Enter Email Address"]
        XCTAssertTrue(login.exists)
        login.tap()
        login.typeText(validLogin)

        let enterPasswordSecureTextField = app.secureTextFields["Enter Password"]
        XCTAssertTrue(enterPasswordSecureTextField.exists)
        enterPasswordSecureTextField.tap()
        enterPasswordSecureTextField.typeText(validPassword)
        app.buttons["Login"].staticTexts["Login"].tap()

        let saladItem = app.collectionViews.buttons["salad"]
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: saladItem, handler: nil)
        waitForExpectations(timeout: 8)

        saladItem.tap()

        let tablesQuery = app.tables
        tablesQuery.cells.containing(
            .staticText,
            identifier: "Sichuan-Style Smashed Cucumber Salad Recipe"
        )
        .children(matching: .other).element(boundBy: 1).tap()

        let recipesNavigationBar = app.navigationBars["Recipes"]
        XCUIApplication().navigationBars["Recipes"].children(matching: .button).element(boundBy: 2).tap()
        recipesNavigationBar.buttons["arrowBackward"].tap()
        recipesNavigationBar.buttons["arrow.backward"].tap()

        let favoritesButton = app.tabBars["Tab Bar"].buttons["Favorites"]
        favoritesButton.tap()

        let element = tablesQuery.cells.containing(
            .staticText,
            identifier: "Sichuan-Style Smashed Cucumber Salad Recipe"
        )
        .children(matching: .other).element(boundBy: 1)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

// swiftlint:enable all
