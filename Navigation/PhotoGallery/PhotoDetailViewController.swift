//
//  PhotoDetailViewController.swift
//  Navigation
//
//  Created by Alex Permiakov on 11/19/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
  
  private let photoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.toAutoLayout()
    return imageView
  }()
  
  var photo: Photo? {
    didSet {
      photoImageView.image = photo?.photo
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .darkGray
    setupViews()
    photoImageView.enableZoom()
  }
  
  // MARK: Layout
  func setupViews() {
    view.addSubview(photoImageView)
    
    let constraints = [
      
      photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      photoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      photoImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
    ]
    NSLayoutConstraint.activate(constraints)
  }
}

extension UIImageView {
  func enableZoom() {
    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
    isUserInteractionEnabled = true
    addGestureRecognizer(pinchGesture)
  }
  
  @objc
  private func startZooming(_ sender: UIPinchGestureRecognizer) {
    let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
    guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
    sender.view?.transform = scale
    sender.scale = 1
  }
}
