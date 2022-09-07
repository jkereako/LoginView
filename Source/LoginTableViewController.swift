//
//  LoginController.swift
//  LoginView
//
//  Created by Jeff Kereakoglow on 2/11/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import UIKit

final class LoginTableViewController: UITableViewController {
    @IBOutlet private(set) weak var usernameField: UITextField!
    @IBOutlet private(set) weak var passwordField: UITextField!
    @IBOutlet private(set) weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: - Actions
extension LoginTableViewController {
    // This is triggered before `shouldPerformSegueWithIdentifier`
    @IBAction func loginAction(sender: UIButton) {
        let password = Keychain.password(forAccount: usernameField.text ?? "")
        
        if passwordField.text == password {
            return
        }
        
        // Indicate failed login
        ShakeAnimator(view: usernameField).shake()
        ShakeAnimator(view: passwordField).shake()
        ShakeAnimator(view: loginButton).shake()
    }
}

// MARK: - Navigation
extension LoginTableViewController {
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == "login",
              let username = usernameField.text, !username.isEmpty,
              let suppliedPassword = passwordField.text, !suppliedPassword.isEmpty else {
            return false
        }
        
        let actualPassword = Keychain.password(forAccount: username)
        
        // Make sure the passwords match and that `Keychain.password()` has returned a non-empty string
        if suppliedPassword == actualPassword {
            return true
            
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: self)
        
        segue.destination.transitioningDelegate = self
        segue.destination.modalPresentationStyle = .custom
    }
}

// MARK: - UITextFieldDelegate
extension LoginTableViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        // Move on to the password field automatically
        if textField === usernameField {
            passwordField.becomeFirstResponder()
        }
        
        return true
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension LoginTableViewController: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(
        presented: UIViewController,
        presentingController presenting: UIViewController,
        sourceController source: UIViewController) ->
    UIViewControllerAnimatedTransitioning? {
        
        // Find the center of `loginButton` in the container view's coordinate system
        let origin = loginButton.convert(loginButton.center, to: view)
        
        // Match the transition color to the background color of the presented view
        return BubblePresentationAnimator(
            origin: origin, backgroundColor: presented.view.backgroundColor!
        )
    }
}
