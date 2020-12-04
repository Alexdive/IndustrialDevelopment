//
//  UITextField+AppStyle.swift
//  Navigation
//
//  Created by Alex Permiakov on 11/18/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit

// login textfield style
extension UITextField {
  func logInProperties(placeholder: String) {
    self.toAutoLayout()
    self.backgroundColor = .systemGray6
    self.placeholder = placeholder
    self.textColor = .black
    self.tintColor = UIColor(named: "blueVK")
    self.setLeftPaddingPoints(12)
    self.layer.borderColor = UIColor.lightGray.cgColor
    self.autocapitalizationType = .none
  }
}

// padding for text in textfield
extension UITextField {
  func setLeftPaddingPoints(_ amount:CGFloat){
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
    self.leftView = paddingView
    self.leftViewMode = .always
  }
}
