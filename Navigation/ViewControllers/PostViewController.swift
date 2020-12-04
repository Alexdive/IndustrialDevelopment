//
//  PostViewController.swift
//  Navigation
//
//  Created by Alex Permiakov on 12.09.2020.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
  
  var post: PostTitle?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = post?.title
  }
}
