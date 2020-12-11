//
//  InfoViewController.swift
//  Navigation
//
//  Created by Alex Permiakov on 12.09.2020.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

  private lazy var button: UIButton = UIButton(frame: CGRect(
                                                x: view.bounds.width / 2 - 50,
                                                y: view.bounds.height / 2 - 50,
                                                width: 100,
                                                height: 50))
  
      override func viewDidLoad() {
        super.viewDidLoad()

      view.backgroundColor = .lightGray
        
      button.backgroundColor = .darkGray
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
      button.setTitle("Tap me", for: .normal)
      button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
      self.view.addSubview(button)
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
