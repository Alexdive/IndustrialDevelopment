//
//  AppDelegate.swift
//  Navigation
//
//  Created by Alex Permiakov on 12.09.2020.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit

enum AppConfiguration: String, CaseIterable {
    case first = "https://swapi.dev/api/people/1"
    case second = "https://swapi.dev/api/people/2"
    case third = "https://swapi.dev/api/people/3"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var coordinator: MainCoordinator?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let rootController = AnimatedTabBarController()
    
    coordinator = MainCoordinator(tabBarController: rootController)
    
    rootController.coordinator = coordinator
    
    coordinator?.start()
    
    let appConfig = AppConfiguration.allCases.randomElement()
    NetworkService.fetchData(urlString: appConfig?.rawValue)
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = rootController
    window?.makeKeyAndVisible()
    
    return true
  }
}

