//
//  LoginControllerTest.swift
//  LoginView
//
//  Created by Jeff Kereakoglow on 2/11/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import XCTest

class LoginControllerTest: XCTestCase {

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
    app.keyboards.buttons["Done"].tap()
    tablesQuery.buttons["login"].tap()
  }

  func testBothFieldsShakeWhenUsernameFieldIsEmptyAndPasswordFieldIsIncorrect() {
    let app = XCUIApplication()
    let tablesQuery = app.tables

    tablesQuery.secureTextFields["password"].tap()
    tablesQuery.secureTextFields["password"].typeText("not_the_password")
    app.keyboards.buttons["Done"].tap()
    tablesQuery.buttons["login"].tap()
  }

  func testBothFieldsShakeWhenPasswordFieldIsEmptyAndUsernameFieldIsIncorrect() {
    let app = XCUIApplication()
    let tablesQuery = app.tables

    tablesQuery.textFields["username"].tap()
    tablesQuery.textFields["username"].typeText("noone")
    app.keyboards.buttons["Next"].tap()
    app.keyboards.buttons["Done"].tap()
    tablesQuery.buttons["login"].tap()
  }

  func testBothFieldsShakeWhenBothFieldsAreEmpty() {
    let app = XCUIApplication()
    let tablesQuery = app.tables

    tablesQuery.buttons["login"].tap()
  }

  func testBothFieldsShakeWhenBothFieldsAreIncorrect() {
    let app = XCUIApplication()
    let tablesQuery = app.tables
    
    tablesQuery.textFields["username"].tap()
    tablesQuery.textFields["username"].typeText("noone")
    app.keyboards.buttons["Next"].tap()
    tablesQuery.secureTextFields["password"].typeText("not_the_password")
    app.keyboards.buttons["Done"].tap()
    tablesQuery.buttons["login"].tap()
  }

  func testSuccessfulLoginWhenBothFieldsAreCorrect() {
    let app = XCUIApplication()
    let tablesQuery = app.tables

    tablesQuery.textFields["username"].tap()
    tablesQuery.textFields["username"].typeText("jonsnow")
    app.keyboards.buttons["Next"].tap()
    tablesQuery.secureTextFields["password"].typeText("wallwatcher247")
    app.keyboards.buttons["Done"].tap()
    tablesQuery.buttons["login"].tap()
  }
}
