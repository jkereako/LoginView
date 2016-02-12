//
//  AppDelegate.swift
//  LoginView
//
//  Created by Jeff Kereakoglow on 2/11/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
  var window: UIWindow?
}

extension AppDelegate: UIApplicationDelegate {
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {

    Keychain.setString("jonsnow", forKey: Constants.KeychainKeys.Username)
    Keychain.setString("wallwatcher247", forKey: Constants.KeychainKeys.Password)

    return true
  }
}

