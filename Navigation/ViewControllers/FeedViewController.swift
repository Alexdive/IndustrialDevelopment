//
//  ViewController.swift
//  Navigation
//
//  Created by Alex Permiakov on 12.09.2020.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit
import SnapKit

final class FeedViewController: UIViewController {
  
  weak var coordinator: FeedNavCoordinator?
  
  let post = PostTitle(title: "Some post title")
  
  private var buttonOne: UIButton = {
    let button = UIButton()
    button.setTitle("Post", for: .normal)
    button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    return button
  }()
  
  private var buttonTwo: UIButton = {
    let button = UIButton()
    button.setTitle("One More Post", for: .normal)
    button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
  }
  
  @objc func buttonPressed(_ sender: UIButton) {
    coordinator?.showPost(post: post)
  }

  private func setupLayout() {
    view.backgroundColor = .systemTeal
    title = "Feed"
    
    let stackView = UIStackView(arrangedSubviews: [buttonOne, buttonTwo])
    stackView.axis = .vertical
    stackView.spacing = 10.0
    
    view.addSubview(stackView)
    
    stackView.snp.makeConstraints { (make) in
      make.center.equalToSuperview()
    }
  }
}
