//
//  LoginControllerTests.swift
//  LoginView
//
//  Created by Jeffrey Kereakoglow on 4/26/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import XCTest
@testable import LoginView

final class LoginTableViewControllerTests: XCTestCase {
    private enum Identifier: String {
        case Storyboard = "Main"
        case ViewController = "loginView"
    }
    private var sut: LoginTableViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(
            name: Identifier.Storyboard.rawValue, bundle: Bundle.main
        )
        
        sut = storyboard.instantiateViewController(withIdentifier: Identifier.ViewController.rawValue) as?
        LoginTableViewController
        
        // This line gurantees that the initial view controller is the TableViewController
        UIApplication.shared.keyWindow!.rootViewController = sut
    }
    
    func testStoryboardIsNotNil() {
        XCTAssertNotNil(
            UIStoryboard(name: Identifier.Storyboard.rawValue, bundle: Bundle.main)
        )
    }
    
    func testViewControllerIsNotNil() {
        let storyboard = UIStoryboard(
            name: Identifier.Storyboard.rawValue, bundle: Bundle.main
        )
        let viewController = storyboard.instantiateViewController(
            withIdentifier: Identifier.ViewController.rawValue
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
