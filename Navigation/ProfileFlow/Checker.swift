//
//  Checker.swift
//  Navigation
//
//  Created by Alex Permiakov on 3/31/21.
//  Copyright © 2021 Alex Permiakov. All rights reserved.
//

import Foundation
import FirebaseAuth

struct Checker {
    static func isValidEmail(email: String?) -> Bool {
        guard email != nil else { return false }
        
        let pred = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        return pred.evaluate(with: email)
    }
    
    static func isValidPassword(testStr: String?) -> Bool {
        guard testStr != nil else { return false }
        
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 6 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}")
        return passwordTest.evaluate(with: testStr)
    }
    
    static func logIn(with email: String, passw: String, completion: @escaping (String, UIColor) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: passw) { authResult, error in
            
            if let error = error as NSError? {
                if let errorCode = AuthErrorCode(rawValue: error.code) {
                    switch errorCode {
                    case .userNotFound:
                        signUpAlert(title: "Create new account?",
                                    message: "No account with this email was found\nTap cancel to try again",
                                    text: email)
                        
                    case .wrongPassword:
                        completion("Wrong password, try again", UIColor.systemRed.withAlphaComponent(0.5))
                        
                    default:
                        print(error.localizedDescription)
                    }
                }
            }
            if let authResult = authResult {
                print("logged in \(String(describing: authResult.user.email))")
            }
        }
    }
    
    
    static func signUp() {
        signUpAlert(title: "Create new account",
                    message: "Enter email and password",
                    text: nil)
    }
    
    
    static func signUpAlert(title: String, message: String, text: String?) {
        
        let alert = CustomAlert(title: title,
                                message: message,
                                leftBtnTitle: "Cancel",
                                rightBtnTitle: "Create",
                                leftBtnColor: .systemRed,
                                rightBtnColor: UIColor.AppColor.vkBlue,
                                textFieldPlaceholder: "Enter email",
                                textField2Placeholder: "Enter password",
                                text: text)
        alert.show(animated: true)
        alert.didEnterHandler = { login, passw in
            Auth.auth().createUser(withEmail: login, password: passw) { (authResult, error) in
                
                if let error = error as NSError? {
                    print(error.localizedDescription)
                    if let errorCode = AuthErrorCode(rawValue: error.code) {
                        print(error)
                        switch errorCode {
                        case .emailAlreadyInUse:
                            alert.errorMessage = .emailAlreadyInUse
                        default:
                            print(error.localizedDescription)
                        }
                    }
                } else {
                    print("Created new user")
                    alert.dismiss(animated: true)
                }
            }
        }
    }
}
