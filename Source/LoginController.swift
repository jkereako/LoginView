//
//  LoginController.swift
//  LoginView
//
//  Created by Jeff Kereakoglow on 2/11/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import UIKit

class LoginController: UITableViewController {
  @IBOutlet weak var usernameField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
}

// MARK: - Actions
extension LoginController {
  // This is triggered before `shouldPerformSegueWithIdentifier`
  @IBAction func loginAction(sender: UIButton) {
    let password = Keychain.password(forAccount: usernameField.text ?? "")

    if passwordField.text == password && !password.isEmpty {
        return
    }

    // Indicate failed login
    ShakeAnimator(view: usernameField).shake()
    ShakeAnimator(view: passwordField).shake()
    ShakeAnimator(view: loginButton).shake()
  }
}

// MARK: - Navigation
extension LoginController {
  override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
    guard identifier == "login",
      let username = usernameField.text where !username.isEmpty,
      let suppliedPassword = passwordField.text where !suppliedPassword.isEmpty else {
      return false
    }

    let actualPassword = Keychain.password(forAccount: username)

    // Make sure the passwords match and that `Keychain.password()` has returned a non-empty string
    if suppliedPassword == actualPassword && !actualPassword.isEmpty {
      return true
    }

    return false
  }
}

// MARK: - UITextFieldDelegate
extension LoginController: UITextFieldDelegate {
  func textFieldShouldEndEditing(textField: UITextField) -> Bool {
    return true
  }

  // Dismiss the keyboard when the user hits the return key
  func textFieldShouldReturn(textField: UITextField) -> Bool {

    textField.resignFirstResponder()

    // Move on to the password field automatically
    if textField === usernameField {
      passwordField.becomeFirstResponder()
    }

    return true
  }
}
