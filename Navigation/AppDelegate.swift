//
//  AppDelegate.swift
//  Navigation
//
//  Created by Alex Permiakov on 12.09.2020.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var coordinator: MainCoordinator?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let rootController = AnimatedTabBarController()
    
    coordinator = MainCoordinator(tabBarController: rootController)
    
    rootController.coordinator = coordinator
    
    coordinator?.start()
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = rootController
    window?.makeKeyAndVisible()
    
    return true
  }
  
  
  func applicationDidFinishLaunching(_ application: UIApplication) {
    print(type(of: self), #function)
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    print(type(of: self), #function)
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    print(type(of: self), #function)
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
//    30sec in background mode
    print(type(of: self), #function)
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    print(type(of: self), #function)
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    print(type(of: self), #function)
  }
  
}

