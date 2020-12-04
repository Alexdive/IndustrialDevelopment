//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Alex Permiakov on 11/18/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit


class PhotosTableViewCell: UITableViewCell {
  
  private lazy var stackPhotoView: UIStackView = {
    let stack = UIStackView()
    for i in 0...3 {
      let photo = UIImageView()
      photo.contentMode = .scaleAspectFill
      photo.layer.cornerRadius = 6
      photo.clipsToBounds = true
      photo.image = PhotosStorage.imageNames[i].photo
      stack.addArrangedSubview(photo)
    }
    stack.toAutoLayout()
    stack.axis = .horizontal
    stack.distribution = .fillEqually
    return stack
  }()
  
  private lazy var photoLabel: UILabel = {
    let label = UILabel()
    label.toAutoLayout()
    label.text = "Photos"
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    return label
  }()
  
  private lazy var arrowLabel: UIImageView = {
    let image = UIImageView()
    image.toAutoLayout()
    image.tintColor = .black
    image.image = UIImage(named: "arrow.forward")!
    image.contentMode = .scaleAspectFit
    return image
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupLayout()
    
    self.backgroundColor = .white
    
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  // MARK: Layout
  private func setupLayout() {
    
    let indent: CGFloat = 12
    let stackSpacing: CGFloat = 8
    
    stackPhotoView.spacing = stackSpacing
    
    addSubview(stackPhotoView)
    addSubview(photoLabel)
    addSubview(arrowLabel)
    
    let constraints = [
      
      photoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: indent),
      photoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: indent),
      
      arrowLabel.centerYAnchor.constraint(equalTo: photoLabel.centerYAnchor),
      arrowLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -indent),
      
      stackPhotoView.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: indent),
      stackPhotoView.leadingAnchor.constraint(equalTo: photoLabel.leadingAnchor),
      stackPhotoView.trailingAnchor.constraint(equalTo: arrowLabel.trailingAnchor),
      stackPhotoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -indent),
      stackPhotoView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25, constant: -(stackSpacing*3 + indent*2)/4)
      
    ]
    NSLayoutConstraint.activate(constraints)
  }
}


