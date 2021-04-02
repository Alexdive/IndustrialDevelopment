//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Alex Permiakov on 10/31/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit
import AVKit
import SnapKit

protocol ProfileTableViewDelegate: AnyObject {
  func didTapAvatarButton()
}

class ProfileHeaderView: UIView, UITextFieldDelegate {
  
  weak var delegate: ProfileTableViewDelegate?
  
  var avatarImageHeight: CGFloat = 110
  var avatarImageWidth: CGFloat = 110
  
  var avatarTopConstraint: Constraint? = nil
  var avatarleadingConstraint: Constraint? = nil
  var avatarWidthConstraint: Constraint? = nil
  var avatarHeightConstraint: Constraint? = nil
  
  private lazy var avatarImageView: UIImageView = {
    let avatar = UIImageView()
    avatar.contentMode = .scaleAspectFill
    avatar.image = UIImage(named: "manta")
    avatar.makeRoundedCornerWithBorder(cornerRadius: avatarImageHeight/2, borderWidth: 3, borderColor: UIColor.white.cgColor)
    avatar.isUserInteractionEnabled = true
    return avatar
  }()
  
  lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Reef Manta"
    label.font = .boldSystemFont(ofSize: 18)
    return label
  }()
  
  private lazy var statusLabel: UILabel = {
    let label = UILabel()
    label.text = "Waiting for something..."
    label.textColor = .gray
    label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    return label
  }()
  
  private lazy var setStatusButton: SetStatusButtonView = {
    let button = SetStatusButtonView()
    button.addTarget(self, action: #selector(setStatusButtonAction), for: .touchUpInside)
    return button
  }()
  
  private lazy var statusTextField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = UIColor.AppColor.white
    textField.placeholder = "Add your status here"
    textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    textField.makeRoundedCornerWithBorder(cornerRadius: 12, borderWidth: 1, borderColor: UIColor.black.cgColor)
    textField.setLeftPaddingPoints(10)
    textField.returnKeyType = UIReturnKeyType.done
    textField.addTarget(self, action: #selector(statusTextChanged), for: .editingDidEnd)
    return textField
  }()
  
  private var statusText = String()
  
  private lazy var transparentView: UIView = {
    let view = UIView()
    view.backgroundColor = .init(white: 1, alpha: 0)
    return view
  }()
  
  private lazy var dismissButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "xmark.circle"), for: .normal)
    button.imageView?.contentMode = .scaleAspectFill
    button.tintColor = .black
    button.addTarget(self, action: #selector(dismissFullscreenImage), for: .touchUpInside)
    button.alpha = 0
    return button
  }()
    
    lazy var signOutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "person.crop.circle.badge.minus"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .black
        return button
    }()
    
  //  getting the size for full screen avatar image
  private var avatarFrame: CGRect { return AVMakeRect(aspectRatio: avatarImageView.image!.size, insideRect: UIScreen.main.bounds) }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupLayout()
    
    self.backgroundColor = UIColor.AppColor.lightGray

    self.statusTextField.delegate = self
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapAvatar))
    tapGesture.delegate = self
    avatarImageView.addGestureRecognizer(tapGesture)
    
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  // MARK: Actions
  /// Keyboard dismiss
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  @objc func statusTextChanged(_ textField: UITextField) {
    statusText = statusTextField.text ?? ""
  }
  
  @objc func setStatusButtonAction(sender: UIButton!) {
    UIView.animate(withDuration: 0.2) {
      sender.backgroundColor = UIColor.darkGray
    }
    UIView.animate(withDuration: 0.2) {
      sender.backgroundColor = UIColor.AppColor.vkBlue
    }
    statusTextField.resignFirstResponder()
    statusLabel.text = statusText
    print(statusLabel.text!)
  }
  
//  MARK: Animated avatar
  @objc func didTapAvatar(sender: UITapGestureRecognizer) {
    delegate?.didTapAvatarButton()
    
    addSubview(transparentView)
    bringSubviewToFront(transparentView)
    transparentView.addSubview(dismissButton)
    transparentView.addSubview(avatarImageView)
    transparentView.bringSubviewToFront(avatarImageView)
    transparentView.frame = UIScreen.main.bounds
    dismissButton.frame = CGRect(x: transparentView.frame.maxX - 46,
                                 y: safeAreaInsets.top + 16,
                                 width: 30,
                                 height: 30)
    avatarImageHeight = avatarFrame.height
    avatarImageWidth = avatarFrame.width
    
    avatarImageView.isUserInteractionEnabled = false
    
    avatarImageView.snp.remakeConstraints { (make) in
      self.avatarTopConstraint = make.top.equalTo(avatarFrame.minY).constraint
      self.avatarleadingConstraint = make.left.equalToSuperview().constraint
      self.avatarHeightConstraint = make.height.equalTo(avatarImageHeight).constraint
      self.avatarWidthConstraint = make.width.equalTo(avatarImageWidth).constraint
    }
    setNeedsLayout()
    
    UIView.animate(withDuration: 0.5) { [self] in
      layoutIfNeeded()
      transparentView.backgroundColor = .init(white: 1, alpha: 0.8)
      avatarImageView.layer.cornerRadius = 0
      avatarImageView.layer.borderWidth = 0
    }
    UIView.animate(withDuration: 0.3, delay: 0.5) {
      self.dismissButton.alpha = 1
    }
  }
  
  @objc func dismissFullscreenImage() {
    delegate?.didTapAvatarButton()
    
    avatarImageHeight = 110
    avatarImageWidth = avatarImageHeight
    addSubview(avatarImageView)
    
    avatarImageView.snp.remakeConstraints { (make) -> Void in
      self.avatarTopConstraint = make.top.equalToSuperview().offset(16).constraint
      self.avatarleadingConstraint = make.left.equalToSuperview().offset(16).constraint
      self.avatarHeightConstraint = make.height.equalTo(avatarImageHeight).constraint
      self.avatarWidthConstraint = make.width.equalTo(avatarImageWidth).constraint
    }
    setNeedsLayout()
    
    avatarImageView.isUserInteractionEnabled = true
    
    UIView.animate(withDuration: 0.3) {
      self.dismissButton.alpha = 0
    }
    UIView.animate(withDuration: 0.5, delay: 0.3) { [self] in
      layoutIfNeeded()
      avatarImageView.layer.cornerRadius = avatarImageHeight/2
      transparentView.backgroundColor = .init(white: 1, alpha: 0)
    } completion: { [self] _ in
      avatarImageView.layer.borderWidth = 3
      transparentView.removeFromSuperview()
    }
  }
  
  // MARK: Layout
  private func setupLayout() {
    
    let baseInset: CGFloat = 16
    
    addSubview(avatarImageView)
    addSubview(nameLabel)
    addSubview(statusLabel)
    addSubview(setStatusButton)
    addSubview(statusTextField)
    addSubview(signOutButton)
    
    avatarImageView.snp.makeConstraints { (make) -> Void in
      self.avatarTopConstraint = make.top.equalToSuperview().offset(baseInset).constraint
      self.avatarleadingConstraint = make.left.equalToSuperview().offset(baseInset).constraint
      self.avatarHeightConstraint = make.height.equalTo(avatarImageHeight).constraint
      self.avatarWidthConstraint = make.width.equalTo(avatarImageWidth).constraint
    }
    nameLabel.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(27)
      make.left.equalToSuperview().offset(avatarImageHeight + baseInset * 2)
      make.right.equalTo(self.snp_right).offset(-baseInset)
    }
    signOutButton.snp.makeConstraints {
        $0.top.equalToSuperview().offset(baseInset)
        $0.right.equalTo(nameLabel)
        $0.width.height.equalTo(30)
    }
    setStatusButton.snp.makeConstraints { (make) in
      make.bottom.equalToSuperview().offset(-baseInset)
      make.left.equalToSuperview().offset(baseInset)
      make.right.equalTo(nameLabel)
      make.height.equalTo(50)
    }
    statusTextField.snp.makeConstraints { (make) in
      make.left.equalTo(nameLabel)
      make.right.equalTo(nameLabel)
      make.height.equalTo(40)
      make.bottom.equalTo(setStatusButton.snp_top).offset(-12)
    }
    statusLabel.snp.makeConstraints { (make) in
      make.left.equalTo(nameLabel)
      make.right.equalTo(nameLabel)
      make.bottom.equalTo(statusTextField.snp_top).offset(-12)
    }
    self.snp.makeConstraints { (make) in
      make.height.equalTo(220)
      make.width.equalTo(UIScreen.main.bounds.width)
    }
  }
}

extension ProfileHeaderView: UIGestureRecognizerDelegate {
}
