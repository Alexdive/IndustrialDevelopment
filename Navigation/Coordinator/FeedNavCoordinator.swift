//
//  NavCoordinator.swift
//  Navigation
//
//  Created by Alex Permiakov on 12/14/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit

class FeedNavCoordinator: NavCoordinator {
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    print("Tab coordinator started")
    let vc = FeedViewController()
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: false)
  }
}
