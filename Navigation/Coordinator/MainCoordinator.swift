//
//  MainCoordinator.swift
//  CoordinatorTest
//
//  Created by Alex Permiakov on 12/10/20.
//

import UIKit

class MainCoordinator: TabCoordinator {
  
  var childCoordinators = [NavCoordinator]()
  
  var tabBarController: UITabBarController
  
  init(tabBarController: UITabBarController) {
    self.tabBarController = tabBarController
  }
  
  func start() {
    
    print("Tab coordinator started")
    
    let feedNavController = UINavigationController()
    let icon1 = UITabBarItem(title: "Feed", image: UIImage(named: "house.fill"), tag: 0)
    feedNavController.tabBarItem = icon1
    let feedCoordinator = FeedNavCoordinator(navigationController: feedNavController)
    
    
    let profileNavController = UINavigationController()
    let icon2 = UITabBarItem(title: "Profile", image: UIImage(named: "person.fill"), tag: 1)
    profileNavController.tabBarItem = icon2
    let profileCoordinator = ProfileNavCoordinator(navigationController: profileNavController)
    
    childCoordinators = [feedCoordinator, profileCoordinator]
    
    feedCoordinator.start()
    profileCoordinator.start()
 
    let controllers = [feedNavController, profileNavController]
    tabBarController.viewControllers = controllers
  }
}


