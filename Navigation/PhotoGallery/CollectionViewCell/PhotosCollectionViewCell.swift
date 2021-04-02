//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Alex Permiakov on 11/18/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit
import SnapKit

class PhotosCollectionViewCell: UICollectionViewCell {
  
  
  private let photoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
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
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  // MARK: Layout
  func setupViews() {
    contentView.backgroundColor = UIColor.AppColor.white
    contentView.addSubview(photoImageView)
    
    photoImageView.snp.makeConstraints { (make) in
      make.top.equalToSuperview()
      make.centerX.equalToSuperview()
      make.width.equalToSuperview()
      make.height.equalToSuperview()
    }
  }
}



