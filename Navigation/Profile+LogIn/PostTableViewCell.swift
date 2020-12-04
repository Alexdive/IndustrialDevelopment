//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Alex Permiakov on 11/12/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
  
  private let authorNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    label.textColor = .black
    label.numberOfLines = 2
    label.toAutoLayout()
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    label.textColor = .systemGray
    label.numberOfLines = 0
    label.toAutoLayout()
    return label
  }()
  
  private let postImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = .black
    imageView.toAutoLayout()
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
    
    self.backgroundColor = .systemGray6
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
    likesStackView.toAutoLayout()
    
    let viewsStackView = UIStackView(arrangedSubviews: [viewsLabel, viewsCountLabel])
    viewsStackView.axis = .horizontal
    viewsStackView.spacing = 4
    viewsStackView.toAutoLayout()
    
    let indent: CGFloat = 16
    let imageWidth: NSLayoutDimension = contentView.widthAnchor
    
    contentView.addSubview(authorNameLabel)
    contentView.addSubview(descriptionLabel)
    contentView.addSubview(postImageView)
    contentView.addSubview(likesStackView)
    contentView.addSubview(viewsStackView)
    
    let constraints = [
      
      authorNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: indent),
      authorNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: indent),
      authorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -indent),
      
      postImageView.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 12),
      postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      postImageView.widthAnchor.constraint(equalTo: imageWidth),
      postImageView.heightAnchor.constraint(equalTo: imageWidth),
      
      descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: indent),
      descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: indent),
      descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -indent),
      
      likesStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: indent),
      likesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: indent),
      
      viewsStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: indent),
      viewsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -indent),
      viewsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -indent)
      
    ]
    NSLayoutConstraint.activate(constraints)
  }
}
