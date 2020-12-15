//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Alex Permiakov on 11/18/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit
import SnapKit

class PhotosTableViewCell: UITableViewCell {
  
  private let images = PhotosStorage()
  
  private lazy var stackPhotoView: UIStackView = {
    let stack = UIStackView()
    for i in 0...3 {
      let photo = UIImageView()
      photo.contentMode = .scaleAspectFill
      photo.layer.cornerRadius = 6
      photo.clipsToBounds = true
      photo.image = images.imageNames[i].photo
      stack.addArrangedSubview(photo)
    }
    stack.axis = .horizontal
    stack.distribution = .fillEqually
    return stack
  }()
  
  private lazy var photoLabel: UILabel = {
    let label = UILabel()
    label.text = "Photos"
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    return label
  }()
  
  private lazy var arrowLabel: UIImageView = {
    let image = UIImageView()
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
    
    let baseInset: CGFloat = 12
    let stackSpacing: CGFloat = 8
    
    stackPhotoView.spacing = stackSpacing
    
    addSubview(stackPhotoView)
    addSubview(photoLabel)
    addSubview(arrowLabel)
    
    photoLabel.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(baseInset)
      make.left.equalToSuperview().offset(baseInset)
    }
    arrowLabel.snp.makeConstraints { (make) in
      make.centerY.equalTo(photoLabel.snp.centerY)
      make.right.equalToSuperview().offset(-baseInset)
    }
    stackPhotoView.snp.makeConstraints { (make) in
      make.top.equalTo(photoLabel.snp_bottom).offset(baseInset)
      make.left.equalTo(photoLabel.snp_left)
      make.right.equalTo(arrowLabel.snp_right)
      make.bottom.equalToSuperview().offset(-baseInset)
      make.height.equalTo(self.snp_width).dividedBy(4).offset(-(stackSpacing*3 + baseInset*2)/4)
    }
  }
}


