//
//  InfoViewController.swift
//  Navigation
//
//  Created by Alex Permiakov on 12.09.2020.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit
import SnapKit

class InfoViewController: UIViewController {
  
  private lazy var alertButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .darkGray
    button.layer.cornerRadius = 25
    button.clipsToBounds = true
    button.setTitle("Show alert", for: .normal)
    button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .lightGray
    
    setupLayout()
  }
  
  private func setupLayout() {
    self.view.addSubview(alertButton)
    alertButton.snp.makeConstraints { (make) in
      make.center.equalToSuperview()
      make.size.equalTo(CGSize(width: 150, height: 70))
    }
  }
  
  @objc private func showAlert() {
    let alertController = UIAlertController(title: "Удалить пост?", message: "Пост нельзя будет восстановить", preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in
      print("Отмена")
    }
    let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
      print("Удалить")
    }
    alertController.addAction(cancelAction)
    alertController.addAction(deleteAction)
    self.present(alertController, animated: true, completion: nil)
  }
}
