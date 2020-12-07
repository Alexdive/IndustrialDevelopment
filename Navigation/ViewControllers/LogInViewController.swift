//
//  LogInViewController.swift
//  Navigation
//
//  Created by Alex Permiakov on 11/11/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit
import SnapKit

class LogInViewController: UIViewController, UITextFieldDelegate {
  
  // MARK: properties
  private lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.showsVerticalScrollIndicator = false
    return scrollView
  }()
  
  private let contentView: UIView = {
    let view = UIView()
    return view
  }()
  
  private var logoVKImage: UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "logo")
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private var logInTextField: UITextField = {
    let textField = UITextField()
    textField.logInProperties(placeholder: "Email or phone")
    textField.layer.borderWidth = 0.5
    textField.layer.borderColor = UIColor.lightGray.cgColor
    textField.returnKeyType = UIReturnKeyType.continue
    textField.addTarget(self, action: #selector(logInTextEntered), for: .editingDidEnd)
    return textField
  }()
  
  private var passwordTextField: UITextField = {
    let textField = UITextField()
    textField.logInProperties(placeholder: "Password")
    textField.isSecureTextEntry = true
    textField.returnKeyType = UIReturnKeyType.go
    textField.addTarget(self, action: #selector(passwordTextEntered), for: .editingDidEnd)
    return textField
  }()
  
  private var logInButton: UIButton = {
    let button = UIButton()
    button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
    button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .disabled)
    button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .selected)
    button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .highlighted)
    button.setTitle("Log in", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 10
    button.clipsToBounds = true
    button.addTarget(self, action: #selector(logInButtonAction), for: .touchUpInside)
    return button
  }()
  
  let profileView = ProfileViewController()
  
  private var loginIsEntered = false
  private var passwordIsEntered = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    setupLayout()
    
    self.logInTextField.delegate = self
    self.passwordTextField.delegate = self
    
    /// Keyboard observers
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = true
  }
  
  
  /// Keyboard dismiss
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  // MARK: Actions
  @objc func logInTextEntered(_ textField: UITextField) {
    if let text = logInTextField.text, !text.isEmpty {
      loginIsEntered = true
      passwordTextField.becomeFirstResponder()
    } else {
      logInTextField.placeholder = "Login can't be empty!"
      logInTextField.becomeFirstResponder()
    }
  }
  
  @objc private func passwordTextEntered(_ textField: UITextField) {
    if let text = passwordTextField.text, !text.isEmpty {
      passwordIsEntered = true
      print("Password entered")
    } else {
      passwordTextField.placeholder = "Password can't be empty!"
      passwordTextField.becomeFirstResponder()
    }
  }
  
  @objc private func logInButtonAction() {
    print("logged in")
    self.navigationController?.pushViewController(profileView, animated: true)
    passwordTextField.resignFirstResponder()
    logInTextField.resignFirstResponder()
  }
  
  // MARK: Keyboard actions
  @objc fileprivate func keyboardWillShow(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
      scrollView.contentInset.bottom = keyboardSize.height + (logInTextField.isFirstResponder ? 82 : 32)
    }
  }
  
  @objc fileprivate func keyboardWillHide(notification: NSNotification) {
    scrollView.contentInset.bottom = .zero
  }
  
  // MARK: Layout
  private func setupLayout() {
    
    let baseInset: CGFloat = 16
    
    let stackView = UIStackView(arrangedSubviews: [logInTextField, passwordTextField])
    stackView.axis = .vertical
    stackView.spacing = 0
    stackView.makeRoundedCornerWithBorder(cornerRadius: 10, borderWidth: 0.5, borderColor: UIColor.lightGray.cgColor)
    
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    contentView.addSubview(logoVKImage)
    contentView.addSubview(stackView)
    contentView.addSubview(logInButton)
    
    scrollView.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(view)
    }
    contentView.snp.makeConstraints { (make) -> Void in
      make.edges.equalToSuperview()
      make.width.equalToSuperview()
    }
    logoVKImage.snp.makeConstraints { (make) -> Void in
      make.top.equalToSuperview().offset(120)
      make.centerX.equalToSuperview()
      make.width.height.equalTo(100)
    }
    logInTextField.snp.makeConstraints { (make) in
      make.height.equalTo(50.5)
    }
    passwordTextField.snp.makeConstraints { (make) in
      make.height.equalTo(50)
    }
    stackView.snp.makeConstraints { (make) in
      make.top.equalTo(logoVKImage.snp_bottom).offset(120)
      make.left.equalToSuperview().offset(baseInset)
      make.right.equalToSuperview().offset(-baseInset)
    }
    logInButton.snp.makeConstraints { (make) in
      make.top.equalTo(stackView.snp_bottom).offset(baseInset)
      make.left.equalToSuperview().offset(baseInset)
      make.right.equalToSuperview().offset(-baseInset)
      make.height.equalTo(50)
      make.bottom.equalToSuperview()
    }
  }
}


