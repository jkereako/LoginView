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

  private let username = Keychain.stringForKey(Constants.KeychainKeys.Username)
  private let password = Keychain.stringForKey(Constants.KeychainKeys.Password)
}

// MARK: - Actions
extension LoginController {
  // This is triggered before `shouldPerformSegueWithIdentifier`
  @IBAction func loginAction(sender: UIButton) {
    if usernameField.text != username {
      let animator = TextFieldShakeAnimator(speed: 0.08, amplitude: 5, count: 6, textField: usernameField)
      animator.shake()
    }

    if passwordField.text != password {
      let animator = TextFieldShakeAnimator(speed: 0.08, amplitude: 5, count: 6, textField: passwordField)
      animator.shake()
    }
  }
}

// MARK: - Navigation
extension LoginController {
  override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
    guard identifier == "login" else {
      return false
    }

    if usernameField.text == username && passwordField.text == password {
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
