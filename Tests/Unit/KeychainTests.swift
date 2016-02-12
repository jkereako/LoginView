//
//  KeychainTests.swift
//  Keychain
//
//  Created by Hyper on 12/14/15.
//  Copyright © 2016 Hyper. All rights reserved.
//

import XCTest
@testable import LoginView

class KeychainTests: XCTestCase {

  let service = "keychain"
  let password = "banana45?!"
  let account = "John Hyperseed"

  override func tearDown() {
    Keychain.deletePassword(forAccount: account, service: service)
  }

  func testAddingPasswordForService() {
    let success = Keychain.setPassword(password, forAccount: account, service: service)

    XCTAssertTrue(success)
  }

  func testUpdatePasswordForService() {
    Keychain.setPassword(password, forAccount: account, service: service)
    XCTAssertEqual(password, Keychain.password(forAccount: account, service: service))

    let newPassword = "apple641"
    let success = Keychain.setPassword(newPassword, forAccount: account, service: service)

    XCTAssertTrue(success)
    XCTAssertEqual(newPassword, Keychain.password(forAccount: account, service: service))
  }

  func testGetPasswordForService() {
    Keychain.setPassword(password, forAccount: account, service: service)

    XCTAssertEqual(password, Keychain.password(forAccount: account, service: service))
  }

  func testDeletePasswordForService() {
    XCTAssertTrue(Keychain.setPassword(password, forAccount: account, service: service))

    Keychain.deletePassword(forAccount: account, service: service)

    XCTAssertNotEqual(password, Keychain.password(forAccount: account, service: service))
  }
}