//
//  AnimatedTabBarController.swift
//  Navigation
//
//  Created by Alex Permiakov on 11/8/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//


//  Animation took from: https://medium.com/@vialyx/ios-dev-course-uitabbarcontroller-animated-transitioning-50b341a150d

import UIKit

class AnimatedTabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
    
    let item1 = FeedViewController()
    let icon1 = UITabBarItem(title: "Feed", image: UIImage(named: "house.fill"), tag: 0)
    item1.tabBarItem = icon1
    let item2 = LogInViewController()
    let icon2 = UITabBarItem(title: "Profile", image: UIImage(named: "person.fill"), tag: 1)
    item2.tabBarItem = icon2
    let controllers = [item1, item2]
    self.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
}

// MARK: - UITabBarControllerDelegate
extension AnimatedTabBarController: UITabBarControllerDelegate {
  
  
  func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return TabBarAnimatedTransitioning()
  }
}


final class TabBarAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let destination = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
    
    destination.alpha = 0.0
    destination.transform = .init(scaleX: 0.5, y: 0.5)
    transitionContext.containerView.addSubview(destination)
    
    UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
      destination.alpha = 1.0
      destination.transform = .identity
    }, completion: { transitionContext.completeTransition($0) })
  }
  
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.25
  }
}



