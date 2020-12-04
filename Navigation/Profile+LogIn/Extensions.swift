//
//  Extensions.swift
//  Navigation
//
//  Created by Alex Permiakov on 11/11/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit

// extension for rounded view with border
extension UIView {
  func makeRoundedCornerWithBorder(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: CGColor) {
    self.layer.cornerRadius = cornerRadius
    self.layer.borderWidth = borderWidth
    self.layer.borderColor = borderColor
    self.clipsToBounds = true
  }
}

// switch to auto layout
extension UIView {
  func toAutoLayout() {
    self.translatesAutoresizingMaskIntoConstraints = false
  }
}
