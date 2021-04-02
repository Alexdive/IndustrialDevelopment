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
  
  let photoViewModel = PhotosViewModel()
  
  func start() {
    let vc = LogInViewController()
    vc.coordinator = self
    navigationController.setViewControllers([vc], animated: true)
  }
  
  func logIn() {
    let vc = ProfileViewController()
    vc.coordinator = self
    navigationController.setViewControllers([vc], animated: true)
  }
  
  func openPhotoGallery() {
    let vc = PhotosViewController()
    vc.vm = photoViewModel
    vc.coordinator = self
    push(vc: vc, animated: true)
  }
  
  func openPhotoDetails(index: IndexPath) {
    let vc = PhotoDetailViewController()
    vc.photo = photoViewModel.storage.imageNames[index.item]
    push(vc: vc, animated: true)
  }
}

