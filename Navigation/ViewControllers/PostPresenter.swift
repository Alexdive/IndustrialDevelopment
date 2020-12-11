//
//  PostPresenter.swift
//  Navigation
//
//  Created by Alex Permiakov on 12/10/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit

class PostPresenter: FeedViewOutput {
  
  let post = PostTitle(title: "Some title")
  
  var navigationController: UINavigationController?
  
  func showPost() {
    let postVC = PostViewController()
    postVC.post = post
    navigationController?.pushViewController(postVC, animated: true)
  }
}
