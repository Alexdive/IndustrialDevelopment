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
    let vc = FeedViewController()
    vc.viewModel = ViewModel()
    vc.coordinator = self
    push(vc: vc, animated: false)
  }
  
  func showPost(post: PostTitle) {
    let vc = PostViewController()
    vc.viewModel = PostViewModel()
    vc.coordinator = self
    vc.post = post
    push(vc: vc, animated: true)
  }
  
  func showInfo() {
    let vc = InfoViewController()
      navigationController.present(vc, animated: true, completion: nil)
  }
}
