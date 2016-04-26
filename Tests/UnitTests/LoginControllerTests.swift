//
//  LoginControllerTests.swift
//  LoginView
//
//  Created by Jeffrey Kereakoglow on 4/26/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import XCTest
@testable import LoginView

final class LoginControllerTests: XCTestCase {
  private enum Identifier: String {
    case Storyboard = "Main"
    case ViewController = "loginView"
  }
  private var sut: LoginController!

  override func setUp() {
    let storyboard = UIStoryboard(
      name: Identifier.Storyboard.rawValue, bundle: NSBundle.mainBundle()
    )

    sut = storyboard.instantiateViewControllerWithIdentifier(Identifier.ViewController.rawValue) as!
    LoginController

    // This line gurantees that the initial view controller is the TableViewController
    UIApplication.sharedApplication().keyWindow!.rootViewController = sut
  }

  func testStoryboardIsNotNil() {
    XCTAssertNotNil(
      UIStoryboard(name: Identifier.Storyboard.rawValue, bundle: NSBundle.mainBundle())
    )
  }

  func testViewControllerIsNotNil() {
    let storyboard = UIStoryboard(
      name: Identifier.Storyboard.rawValue, bundle: NSBundle.mainBundle()
    )
    let viewController = storyboard.instantiateViewControllerWithIdentifier(
      Identifier.ViewController.rawValue
      )

    XCTAssertNotNil(viewController)
  }

  func testOutletsAreNotNil() {
    // Assert all of the outlets are hooked up
    XCTAssertNotNil(sut.usernameField)
    XCTAssertNotNil(sut.passwordField)
    XCTAssertNotNil(sut.loginButton)
  }
}
