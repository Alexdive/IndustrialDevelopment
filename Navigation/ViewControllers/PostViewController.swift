//
//  PostViewController.swift
//  Navigation
//
//  Created by Alex Permiakov on 12.09.2020.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
  
  weak var coordinator: FeedNavCoordinator?
  
  var post: PostTitle?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .purple
    title = post?.title
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showInfo))
  }
  
  @objc func showInfo() {
    coordinator?.showInfo()
  }
}
