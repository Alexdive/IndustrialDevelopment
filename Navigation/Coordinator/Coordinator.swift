//
//  Coordinator.swift
//  CoordinatorTest
//
//  Created by Alex Permiakov on 12/10/20.
//

import UIKit

protocol TabCoordinator: AnyObject {
  var childCoordinators: [NavCoordinator] { get set }
  var tabBarController: UITabBarController { get set }
  func start()
}

protocol NavCoordinator: AnyObject {
  var navigationController: UINavigationController { get set }
  func start()
}

extension NavCoordinator {
  func push(vc: UIViewController, animated: Bool) {
    navigationController.pushViewController(vc, animated: animated)
  }
}
