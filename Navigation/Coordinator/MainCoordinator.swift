//
//  MainCoordinator.swift
//  CoordinatorTest
//
//  Created by Alex Permiakov on 12/10/20.
//

import UIKit
import FirebaseAuth

class MainCoordinator: TabCoordinator {
    
    var handle: AuthStateDidChangeListenerHandle?
    
  var childCoordinators = [NavCoordinator]()
  
  var tabBarController: UITabBarController
  
  init(tabBarController: UITabBarController) {
    self.tabBarController = tabBarController
  }
  
  func start() {
    
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
    
    handle = Auth.auth().addStateDidChangeListener { (auth, user) in

         if let user = user {
             print("logged in user as \(user.email as Any)")
            profileCoordinator.logIn()
         } else {
            print("no logged in user")
            profileCoordinator.start()
         }
     }
 
    let controllers = [feedNavController, profileNavController]
    
    tabBarController.viewControllers = controllers
  }
}


