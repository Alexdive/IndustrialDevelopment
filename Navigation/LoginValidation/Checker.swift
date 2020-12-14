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
  
  func checkCredentials(enteredString: String, completionEnteredString: @escaping (Bool) -> ()) {

   let serverDelay = 2.0
   DispatchQueue.main.asyncAfter(deadline: .now() + serverDelay) {

    completionEnteredString(enteredString == self.login || enteredString == self.password)
   }
  }
}

class LoginValidator: LoginViewControllerDelegate {
  func checkLogin(enteredLogin: String, completion: @escaping (Bool) -> ()) {
    return Checker.shared.checkCredentials(enteredString: enteredLogin, completionEnteredString: completion)
  }
  
  func checkPassword(enteredPswd: String, completion: @escaping (Bool) -> ()) {
    return Checker.shared.checkCredentials(enteredString: enteredPswd, completionEnteredString: completion)
  }
  
}

