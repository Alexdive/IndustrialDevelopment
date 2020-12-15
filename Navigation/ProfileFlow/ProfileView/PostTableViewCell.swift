//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Alex Permiakov on 11/12/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit
import SnapKit

class PostTableViewCell: UITableViewCell {
  
  private let authorNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    label.textColor = .black
    label.numberOfLines = 2
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    label.textColor = .systemGray
    label.numberOfLines = 0
    return label
  }()
  
  private let postImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = .black
    return imageView
  }()
  
  private let likesLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    label.textColor = .black
    label.text = "Likes:"
    return label
  }()
  
  private let likesCountLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    label.textColor = UIColor(named: "blueVK")
    return label
  }()
  
  private let viewsLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    label.textColor = .black
    label.text = "Views:"
    return label
  }()
  
  private let viewsCountLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    label.textColor = UIColor(named: "blueVK")
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.backgroundColor = UIColor(named: "gray6")

    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  internal func configure(post: Post) {
    authorNameLabel.text = post.author
    descriptionLabel.text = post.description
    postImageView.image = UIImage(named: post.image)
    likesCountLabel.text = "\(post.likes)"
    viewsCountLabel.text = "\(post.views)"
  }
  
  
  // MARK: Layout
  private func setupLayout() {
    
    // added stack views, in order to be able change text formating
    let likesStackView = UIStackView(arrangedSubviews: [likesLabel, likesCountLabel])
    likesStackView.axis = .horizontal
    likesStackView.spacing = 4
    
    let viewsStackView = UIStackView(arrangedSubviews: [viewsLabel, viewsCountLabel])
    viewsStackView.axis = .horizontal
    viewsStackView.spacing = 4
    
    let baseInset: CGFloat = 16
    
    contentView.addSubview(authorNameLabel)
    contentView.addSubview(descriptionLabel)
    contentView.addSubview(postImageView)
    contentView.addSubview(likesStackView)
    contentView.addSubview(viewsStackView)
    
    authorNameLabel.snp.makeConstraints { (make) in
      make.top.left.equalToSuperview().offset(baseInset)
      make.right.equalToSuperview().offset(-baseInset)
    }
    postImageView.snp.makeConstraints { (make) in
      make.top.equalTo(authorNameLabel.snp_bottom).offset(12)
      make.left.equalToSuperview()
      make.width.equalToSuperview()
      make.height.equalTo(postImageView.snp_width)
    }
    descriptionLabel.snp.makeConstraints { (make) in
      make.top.equalTo(postImageView.snp_bottom).offset(baseInset)
      make.left.equalToSuperview().offset(baseInset)
      make.right.equalToSuperview().offset(-baseInset)
    }
    likesStackView.snp.makeConstraints { (make) in
      make.top.equalTo(descriptionLabel.snp_bottom).offset(baseInset)
      make.left.equalToSuperview().offset(baseInset)
    }
    viewsStackView.snp.makeConstraints { (make) in
      make.top.equalTo(descriptionLabel.snp_bottom).offset(baseInset)
      make.right.bottom.equalToSuperview().offset(-baseInset)
    }
  }
}
