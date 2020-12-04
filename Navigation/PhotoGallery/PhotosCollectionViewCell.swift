//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Alex Permiakov on 11/18/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
  
  
  private let photoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.toAutoLayout()
    imageView.clipsToBounds = true
    return imageView
  }()
  
  var photo: Photo? {
    didSet {
      photoImageView.image = photo?.photo
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupViews()
    contentView.backgroundColor = .white
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  // MARK: Layout
  func setupViews() {
    contentView.addSubview(photoImageView)
    
    let constraints = [
      photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      photoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      photoImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
      photoImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
    ]
    NSLayoutConstraint.activate(constraints)
  }
}



