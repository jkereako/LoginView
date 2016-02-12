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
}

// MARK: - Navigation
extension LoginController {
  override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
    guard identifier == "login" else {
      return false
    }

    return true
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
