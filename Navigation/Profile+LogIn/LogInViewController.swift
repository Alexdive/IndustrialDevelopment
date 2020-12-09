//
//  LogInViewController.swift
//  Navigation
//
//  Created by Alex Permiakov on 11/11/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
  func checkLogin(enteredLogin: String) -> Bool
  func checkPassword(enteredPswd: String) -> Bool
}

class LogInViewController: UIViewController, UITextFieldDelegate {
  
  weak var delegate: LoginViewControllerDelegate?
  
  // MARK: properties
  private lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.toAutoLayout()
    scrollView.showsVerticalScrollIndicator = false
    return scrollView
  }()
  
  private let contentView: UIView = {
    let view = UIView()
    view.toAutoLayout()
    return view
  }()
  
  private var logoVKImage: UIImageView = {
    let imageView = UIImageView()
    imageView.toAutoLayout()
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
    button.toAutoLayout()
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
    
    setupLayout()
    
    self.logInTextField.delegate = self
    self.passwordTextField.delegate = self
    
    print(self)
    print(self.delegate as Any)
    
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
    
//    self.navigationController?.pushViewController(profileView, animated: true)
    
//    if loginIsEntered && passwordIsEntered {
      
    print(self.delegate as Any)
//      if (delegate?.checkLogin(enteredLogin: logInTextField.text!))! && (delegate?.checkPassword(enteredPswd: passwordTextField.text!))! {
//        print("logged in")
//      }
//    }
    
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
    
    let stackView = UIStackView(arrangedSubviews: [logInTextField, passwordTextField])
    stackView.toAutoLayout()
    stackView.axis = .vertical
    stackView.spacing = 0
    stackView.makeRoundedCornerWithBorder(cornerRadius: 10, borderWidth: 0.5, borderColor: UIColor.lightGray.cgColor)
    
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    contentView.addSubview(logoVKImage)
    contentView.addSubview(stackView)
    contentView.addSubview(logInButton)
    
    let constraints = [
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      
      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      
      logoVKImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
      logoVKImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      logoVKImage.widthAnchor.constraint(equalToConstant: 100),
      logoVKImage.heightAnchor.constraint(equalToConstant: 100),
      
      logInTextField.heightAnchor.constraint(equalToConstant: 50),
      passwordTextField.heightAnchor.constraint(equalToConstant: 50),
      stackView.topAnchor.constraint(equalTo: logoVKImage.bottomAnchor, constant: 120),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      
      logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
      logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      logInButton.heightAnchor.constraint(equalToConstant: 50),
      logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ]
    
    NSLayoutConstraint.activate(constraints)
  }
}


