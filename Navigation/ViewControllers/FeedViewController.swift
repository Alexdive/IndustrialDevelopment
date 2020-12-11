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
  
  let post = PostTitle(title: "Some post title")
  
  var backgroundTask: UIBackgroundTaskIdentifier = .invalid
  
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
  
  @objc func buttonPressed(_ sender: UIButton) {
    let postView = PostViewController()
    postView.post = post
    self.navigationController?.pushViewController(postView, animated: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupLayout()
    
    print(type(of: self), #function)
  }
  
  func registerBackgroundTask() {
    backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
      self?.endBackgroundTask()
    }
    assert(backgroundTask != .invalid)
  }
    
  func endBackgroundTask() {
    print("Background task ended.")
    UIApplication.shared.endBackgroundTask(backgroundTask)
    backgroundTask = .invalid
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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    registerBackgroundTask()
    
    print(type(of: self), #function)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    print(type(of: self), #function)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    endBackgroundTask()
    
    print(type(of: self), #function)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    print(type(of: self), #function)
  }
 
}
