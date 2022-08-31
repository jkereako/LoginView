//
//  Keychain.swift
//  LoginView
//
//  Created by Jeffrey Kereakoglow on 8/31/22.
//  Copyright © 2022 Alexis Digital. All rights reserved.
//

import Foundation

final class Keychain {
    private static var store = [String: String]()
    
    static func setPassword(_ password: String, forAccount account: String) {
        store[account] = password
    }
    
    static func password(forAccount account: String) -> String {
        return store[account] ?? ""
    }
}
