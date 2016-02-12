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

    XCUIApplication().launch()
  }

  func testLogin() {
    let app = XCUIApplication()
    let tablesQuery = app.tables
    tablesQuery.textFields["username"].tap()
    tablesQuery.textFields["username"].typeText("jonsnow")
    app.buttons["Next"].tap()
    tablesQuery.secureTextFields["password"].typeText("wallwatcher247")
    app.buttons["Done"].tap()
    tablesQuery.buttons["login"].tap()
  }
}
