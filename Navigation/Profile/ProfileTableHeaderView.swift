//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Alex Permiakov on 10/31/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit
import AVKit

protocol ProfileTableViewDelegate: AnyObject {
  func didTapAvatarButton()
}

class ProfileHeaderView: UIView, UITextFieldDelegate {
  
  weak var delegate: ProfileTableViewDelegate?
  
  let avatarImageHeight: CGFloat = 110
  
  private lazy var avatarImageView: UIImageView = {
    let avatar = UIImageView()
    avatar.toAutoLayout()
    avatar.contentMode = .scaleAspectFill
    avatar.image = UIImage(named: "manta")
    avatar.makeRoundedCornerWithBorder(cornerRadius: avatarImageHeight/2, borderWidth: 3, borderColor: UIColor.white.cgColor)
    avatar.isUserInteractionEnabled = true
    return avatar
  }()
  
  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.toAutoLayout()
    label.text = "Reef Manta"
    label.font = .boldSystemFont(ofSize: 18)
    return label
  }()
  
  private lazy var statusLabel: UILabel = {
    let label = UILabel()
    label.toAutoLayout()
    label.text = "Waiting for something..."
    label.textColor = .gray
    label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    return label
  }()
  
  private lazy var setStatusButton: SetStatusButtonView = {
    let button = SetStatusButtonView()
    button.toAutoLayout()
    button.addTarget(self, action: #selector(setStatusButtonAction), for: .touchUpInside)
    return button
  }()
  
  private lazy var statusTextField: UITextField = {
    let textField = UITextField()
    textField.toAutoLayout()
    textField.backgroundColor = .white
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
  
  //  getting the size for full screen avatar image
  private var avatarFrame: CGRect { return AVMakeRect(aspectRatio: avatarImageView.image!.size, insideRect: UIScreen.main.bounds) }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupLayout()
    
    self.backgroundColor = UIColor(named: "gray6")

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
      sender.backgroundColor = UIColor(named: "blueVK")
    }
    statusTextField.resignFirstResponder()
    statusLabel.text = statusText
    print(statusLabel.text!)
  }
  
//  MARK: Animated avatar
  @objc func didTapAvatar(sender: UITapGestureRecognizer) {
    delegate?.didTapAvatarButton()
    
    addSubview(transparentView)
    transparentView.addSubview(dismissButton)
    transparentView.addSubview(avatarImageView)
    transparentView.bringSubviewToFront(avatarImageView)
    transparentView.frame = UIScreen.main.bounds
    dismissButton.frame = CGRect(x: transparentView.frame.maxX - 46,
                                 y: safeAreaInsets.top + 16,
                                 width: 30,
                                 height: 30)
    
    avatarImageView.translatesAutoresizingMaskIntoConstraints = true
    avatarImageView.isUserInteractionEnabled = false
    
    UIView.animate(withDuration: 0.5) { [self] in
      transparentView.backgroundColor = .init(white: 1, alpha: 0.8)
      avatarImageView.layer.cornerRadius = 0
      avatarImageView.layer.borderWidth = 0
      avatarImageView.frame = avatarFrame
    }
    UIView.animate(withDuration: 0.3, delay: 0.5) {
      self.dismissButton.alpha = 1
    }
  }
  
  @objc func dismissFullscreenImage() {
    delegate?.didTapAvatarButton()
    
    UIView.animate(withDuration: 0.3) {
      self.dismissButton.alpha = 0
    }
    UIView.animate(withDuration: 0.5, delay: 0.3) { [self] in
      avatarImageView.contentMode = .scaleAspectFill
      avatarImageView.frame = CGRect(x: 16,
                                     y: 16,
                                     width: avatarImageHeight,
                                     height: avatarImageHeight)
      avatarImageView.layer.cornerRadius = avatarImageHeight/2
      transparentView.backgroundColor = .init(white: 1, alpha: 0)
    } completion: { [self] _ in
      avatarImageView.layer.borderWidth = 3
      addSubview(avatarImageView)
      avatarImageView.toAutoLayout()
      avatarImageView.isUserInteractionEnabled = true
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
    
    let constraints = [
      
      self.heightAnchor.constraint(equalToConstant: 220),
      
      avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: baseInset),
      avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: baseInset),
      avatarImageView.widthAnchor.constraint(equalToConstant: avatarImageHeight),
      avatarImageView.heightAnchor.constraint(equalToConstant: avatarImageHeight),
      
      nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
      nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: avatarImageHeight + baseInset * 2),
      nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -baseInset),
      
      setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
      setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: baseInset),
      setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -baseInset),
      setStatusButton.heightAnchor.constraint(equalToConstant: 50),
      
      statusTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
      statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -baseInset),
      statusTextField.heightAnchor.constraint(equalToConstant: 40),
      statusTextField.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -12),
      
      statusLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
      statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -baseInset),
      statusLabel.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -12)
    ]
    NSLayoutConstraint.activate(constraints)
  }
}

extension ProfileHeaderView: UIGestureRecognizerDelegate {
}
