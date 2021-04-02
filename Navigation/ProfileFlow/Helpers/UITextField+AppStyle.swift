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
  func logInTF() {
    self.backgroundColor = UIColor.AppColor.lightGray
    self.textColor = .darkGray
    self.tintColor = UIColor.AppColor.vkBlue
    self.setLeftPaddingPoints(12)
    self.layer.borderColor = UIColor.lightGray.cgColor
    self.autocapitalizationType = .none
    self.autocorrectionType = .no
    if #available(iOS 13.0, *) {
        self.rightImage(UIImage(named: "checkmark")?.withTintColor(UIColor.AppColor.vkBlue), imageWidth: 20, padding: 4)
    }
  }
}

// padding for text in textfield
extension UITextField {
  func setLeftPaddingPoints(_ amount:CGFloat){
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
    self.leftView = paddingView
    self.leftViewMode = .always
  }
    
    func rightImage(_ image: UIImage?, imageWidth: CGFloat, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: imageWidth, height: frame.height)
        imageView.contentMode = .center
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: imageWidth + 2 * padding, height: frame.height))
        containerView.addSubview(imageView)
        rightView = containerView
    }
    
}
