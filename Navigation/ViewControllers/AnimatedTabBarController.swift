//
//  AnimatedTabBarController.swift
//  Navigation
//
//  Created by Alex Permiakov on 11/8/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//


// код честно украден отсюда: https://medium.com/@vialyx/ios-dev-course-uitabbarcontroller-animated-transitioning-50b341a150d

import UIKit

class AnimatedTabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
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

