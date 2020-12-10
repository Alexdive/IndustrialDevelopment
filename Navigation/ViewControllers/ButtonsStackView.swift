//
//  ButtonsStackView.swift
//  Navigation
//
//  Created by Alex Permiakov on 12/9/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit

class ButtonsStackView: UIStackView {
  
  var onTap: (() -> Void)?

  private var buttonOne: UIButton = {
    let button = UIButton()
    button.setTitle("Tap me", for: .normal)
    button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    return button
  }()
  
  private var buttonTwo: UIButton = {
    let button = UIButton()
    button.setTitle("Or me", for: .normal)
    button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addArrangedSubview(buttonOne)
    addArrangedSubview(buttonTwo)
    self.axis = .vertical
    self.spacing = 20.0
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc func buttonPressed(_ sender: UIButton) {
    onTap?()
  }
  
}
