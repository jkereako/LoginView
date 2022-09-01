//
//  LoginControllerTest.swift
//  LoginView
//
//  Created by Jeff Kereakoglow on 2/11/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import XCTest

final class LoginTableViewControllerTest: XCTestCase {
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launchArguments = ["ResetTestCredentials"]
        app.launch()
    }
    
    func testBothFieldsShakeWhenUsernameFieldIsEmptyAndPasswordFieldIsCorrect() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        
        tablesQuery.secureTextFields["password"].tap()
        tablesQuery.secureTextFields["password"].typeText("wallwatcher247")
        app.keyboards.buttons["done"].tap()
        tablesQuery.buttons["login"].tap()
        
        // Test that the text "Login" is still visible, which indicates failed authentication
        XCTAssert(app.staticTexts["loginViewTitle"].exists)
    }
    
    func testBothFieldsShakeWhenUsernameFieldIsEmptyAndPasswordFieldIsIncorrect() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        
        tablesQuery.secureTextFields["password"].tap()
        tablesQuery.secureTextFields["password"].typeText("not_the_password")
        app.keyboards.buttons["done"].tap()
        tablesQuery.buttons["login"].tap()
        
        XCTAssert(app.staticTexts["loginViewTitle"].exists)
    }
    
    func testBothFieldsShakeWhenPasswordFieldIsEmptyAndUsernameFieldIsIncorrect() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        
        tablesQuery.textFields["username"].tap()
        tablesQuery.textFields["username"].typeText("noone")
        app.keyboards.buttons["next"].tap()
        app.keyboards.buttons["done"].tap()
        tablesQuery.buttons["login"].tap()
        
        XCTAssert(app.staticTexts["loginViewTitle"].exists)
    }
    
    func testBothFieldsShakeWhenBothFieldsAreEmpty() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        
        tablesQuery.buttons["login"].tap()
        
        XCTAssert(app.staticTexts["loginViewTitle"].exists)
    }
    
    func testBothFieldsShakeWhenBothFieldsAreIncorrect() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        
        tablesQuery.textFields["username"].tap()
        tablesQuery.textFields["username"].typeText("noone")
        app.keyboards.buttons["next"].tap()
        tablesQuery.secureTextFields["password"].typeText("not_the_password")
        app.keyboards.buttons["done"].tap()
        tablesQuery.buttons["login"].tap()
        
        XCTAssert(app.staticTexts["loginViewTitle"].exists)
    }
    
    func testSuccessfulLoginWhenBothFieldsAreCorrect() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        
        tablesQuery.textFields["username"].tap()
        tablesQuery.textFields["username"].typeText("jonsnow")
        app.keyboards.buttons["next"].tap()
        tablesQuery.secureTextFields["password"].typeText("wallwatcher247")
        app.keyboards.buttons["done"].tap()
        tablesQuery.buttons["login"].tap()
        
        // Assert that authentication was successful
        XCTAssert(app.staticTexts["authenticatedViewTitle"].exists)
    }
}
