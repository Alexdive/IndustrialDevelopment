//
//  ViewController.swift
//  Navigation
//
//  Created by Alex Permiakov on 12.09.2020.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit

protocol FeedViewOutput {
  
  var navigationController: UINavigationController? { get set }
  
  func showPost()
}


final class FeedViewController: UIViewController {
  
  var output: FeedViewOutput?
  
  let buttonStack = ButtonsStackView()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    buttonStack.onTap = { [weak self] in
      self?.output?.showPost()
    }
    
    output?.navigationController = self.navigationController
    
    view.addSubview(buttonStack)
    buttonStack.toAutoLayout()
    buttonStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    buttonStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
  }
}
