//
//  ViewController.swift
//  Navigation
//
//  Created by Alex Permiakov on 12.09.2020.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController {
  
  let post = PostTitle(title: "Пост")
  
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
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let postView = storyBoard.instantiateViewController(withIdentifier: "postView") as! PostViewController
    postView.post = post
    self.show(postView, sender: self)
  }
  
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    print(type(of: self), #function)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    print(type(of: self), #function)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let stackView = UIStackView(arrangedSubviews: [buttonOne, buttonTwo])
    stackView.axis = .vertical
    stackView.spacing = 10.0
    view.addSubview(stackView)
    stackView.toAutoLayout()
    stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    
    print(type(of: self), #function)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print(type(of: self), #function)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    print(type(of: self), #function)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    print(type(of: self), #function)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    print(type(of: self), #function)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    print(type(of: self), #function)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    print(type(of: self), #function)
  }
}
