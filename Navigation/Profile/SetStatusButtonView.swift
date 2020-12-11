//
//  SetStatusButtonView.swift
//  Navigation
//
//  Created by Alex Permiakov on 11/2/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit


class SetStatusButtonView: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setTitle("Set status", for: .normal)
    self.setTitleColor(.white, for: .normal)
    self.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    self.backgroundColor = UIColor(named: "blueVK")
    self.layer.cornerRadius = 14
    self.layer.shadowOffset = CGSize(width: 4, height: 4)
    self.layer.shadowRadius = 4
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOpacity = 0.7
  }
  
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}
