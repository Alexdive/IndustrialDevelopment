//
//  ProfileNavCoordinator.swift
//  Navigation
//
//  Created by Alex Permiakov on 12/14/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit

class ProfileNavCoordinator: NavCoordinator {
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let vc = LogInViewController()
    vc.coordinator = self
    push(vc: vc, animated: false)
  }
  
  func logIn() {
    let vc = ProfileViewController()
    vc.coordinator = self
    push(vc: vc, animated: true)
  }
  
  func openPhotoGallery() {
    let vc = PhotosViewController()
    vc.coordinator = self
    push(vc: vc, animated: true)
  }
  
  func openPhotoDetails(index: IndexPath) {
    let vc = PhotoDetailViewController()
    vc.photo = PhotosStorage.imageNames[index.item]
    push(vc: vc, animated: true)
  }
}

