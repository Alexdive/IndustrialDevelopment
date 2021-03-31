//
//  Checker.swift
//  Navigation
//
//  Created by Alex Permiakov on 3/31/21.
//  Copyright © 2021 Alex Permiakov. All rights reserved.
//

import Foundation

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
}
