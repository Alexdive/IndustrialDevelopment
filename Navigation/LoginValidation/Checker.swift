//
//  Checker.swift
//  Navigation
//
//  Created by Alex Permiakov on 12/9/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import Foundation

class Checker {
  
  static let shared = Checker()
  
  private init() {}
  
  let login = "reef"
  let password = "manta"
  
  func checkCredentials(enteredString: String) -> Bool {
    return enteredString == login || enteredString == password
  }
}

class LoginValidator: LoginViewControllerDelegate {
  
  func checkLogin(enteredLogin: String) -> Bool {
    print("L delegate")
    return Checker.shared.checkCredentials(enteredString: enteredLogin)
  }
  
  func checkPassword(enteredPswd: String) -> Bool {
    print("P delegate")
    return Checker.shared.checkCredentials(enteredString: enteredPswd)
  }
  
  
}
