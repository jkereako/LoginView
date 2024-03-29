//
//  AppDelegate.swift
//  LoginView
//
//  Created by Jeff Kereakoglow on 2/11/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder {
    var window: UIWindow?
}

// MARK: - UIApplicationDelegate
extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // see: http://stackoverflow.com/questions/32667201/accessing-the-host-app-code-from-the-xcode-7-ui-test-target#33466038
        var arguments = ProcessInfo.processInfo.arguments
        arguments.removeFirst()
        
        // Why do we have to set credentials for UI tests here instead of the test itself? From Konnor
        // on StackOverflow:
        //  "The UI tests are a separate module from the app, therefore not run inside your app as a
        //  logic test would. The only way for them to share code is to compile in all the app files you
        //  need to share between the two modules"
        //
        // I tried setting the keychain credentials in the UI test case class, and although it did
        // compile and run, the credentials only existed in the space of the UI test. The logic which
        // compares the supplied username and password with the stored usename and password in
        // LoginController always failed because the credentials were always empty. Hence, we have to
        // set the test credentials here.
        
        if arguments.contains("ResetTestCredentials") {
            Keychain.setPassword("wallwatcher247", forAccount: "jonsnow")
        }
        
        // Keep the login easy to type
        Keychain.setPassword("bbb", forAccount: "aaa")
        
        return true
    }
}
