//
//  CustomAlertView.swift
//  Manhattan
//
//  Created by Alex Permiakov on 3/19/21.
//  Copyright © 2021 Manhattan. All rights reserved.
//

import UIKit

enum ErrorMessage: String {
    case emailAlreadyInUse = "This email is already registered!\n Try another one"
    case none = ""
}

final class CustomAlert: UIView, Modal {
    
    // MARK: - Properties
    
    var didEnterHandler: ((String, String) -> Void)?
    
    var errorMessage = ErrorMessage.none {
        didSet {
            self.messageLabel.text = errorMessage.rawValue
        }
    }
    
    private var viewTranslation = CGPoint(x: 0, y: 0)
    
    private var withMessage = false
    private var with2TextFields = false
    private var validEmailFlag = false
    private var isFirstPasswordEntry = true
    
    private var enteredEmail: String?
    private var enteredPassword: String?
    
    var backgroundView = UIView()
    var dialogView = UIView()
    
    private let scrollView: UIScrollView = {
      let scrollView = UIScrollView()
      scrollView.translatesAutoresizingMaskIntoConstraints = false
      scrollView.showsVerticalScrollIndicator = false
      return scrollView
    }()
    
    private let titleLabel: UILabel = {
        let tl = UILabel()
        tl.textAlignment = .center
        tl.font = UIFont.boldSystemFont(ofSize: 22)
        tl.textColor = .darkGray
        tl.translatesAutoresizingMaskIntoConstraints = false
        return tl
    }()
    
    private let messageLabel: UILabel = {
        let ml = UILabel()
        ml.textAlignment = .center
        ml.font = UIFont.systemFont(ofSize: 16)
        ml.textColor = .lightGray
        ml.numberOfLines = 0
        ml.translatesAutoresizingMaskIntoConstraints = false
        return ml
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.logInTF()
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.cornerRadius = 12
        textField.clipsToBounds = true
        textField.keyboardType = .emailAddress
        textField.textContentType = .username
        textField.returnKeyType = UIReturnKeyType.continue
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let textField2: UITextField = {
        let textField = UITextField()
        textField.logInTF()
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.cornerRadius = 12
        textField.clipsToBounds = true
        textField.returnKeyType = UIReturnKeyType.done
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.isEnabled = false
        textField.isHidden = true
        textField.textContentType = .newPassword
        return textField
    }()
    
    private let leftActionButton: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.setBackgroundColor(.systemGray, forState: .highlighted)
        btn.addBorders(edges: [.top, .right], color: .lightGray, inset: 0, thickness: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let rightActionButton: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.setBackgroundColor(.systemGray, forState: .highlighted)
        btn.addBorders(edges: [.top], color: .lightGray, inset: 0, thickness: 1)
        btn.setTitleColor(.lightGray, for: .disabled)
        btn.isEnabled = false
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // MARK: - Initializer
//    Use this initialiser for setting up custom alert.
    
    convenience init(title: String, message: String? = nil, leftBtnTitle: String, rightBtnTitle: String, leftBtnColor: UIColor? = nil, rightBtnColor: UIColor? = nil, textFieldPlaceholder: String? = nil, textField2Placeholder: String? = nil, text: String? = nil) {
        self.init(frame: UIScreen.main.bounds)
        
        if let message = message {
            withMessage = true
            messageLabel.text = message
        }
        
        if let textField2Placeholder = textField2Placeholder {
            with2TextFields = true
            textField2.placeholder = textField2Placeholder
            textField2.isHidden = false
        }
        
        setView()
        
        titleLabel.text = title
        textField.placeholder = textFieldPlaceholder
        if Checker.isValidEmail(email: text) {
            textField.text = text
            textField.rightViewMode = .always
            validEmailFlag = true
            textField2.isEnabled = true
            textField2.becomeFirstResponder()
        } else {
            textField.becomeFirstResponder()
        }
        leftActionButton.setTitle(leftBtnTitle, for: .normal)
        rightActionButton.setTitle(rightBtnTitle, for: .normal)
        leftActionButton.setTitleColor(leftBtnColor ?? .systemRed, for: .normal)
        rightActionButton.setTitleColor(rightBtnColor ?? .black, for: .normal)
        
        /// Keyboard observers
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
      
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: Keyboard actions
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height + (textField.isFirstResponder ? 112 : 48)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
    }
    
    // MARK: - Setup
    
    private func setView() {
        
        addSubview(backgroundView)
        addSubview(scrollView)
        scrollView.addSubview(dialogView)
        [titleLabel, messageLabel, textField, textField2, leftActionButton, rightActionButton].forEach { dialogView.addSubview($0) }

        leftActionButton.addTarget(self, action: #selector(didCancel), for: .touchUpInside)
        rightActionButton.addTarget(self, action: #selector(didEnter), for: .touchUpInside)
        textField.addTarget(self, action: #selector(text1Entered), for: .editingChanged)
        textField2.addTarget(self, action: #selector(text2Entered), for: .editingChanged)
        
        dialogView.backgroundColor = UIColor.AppColor.white
        dialogView.layer.cornerRadius = 26
        dialogView.clipsToBounds = true
        dialogView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundView.frame = CGRect(x: 0, y: -300, width: frame.width, height: frame.height + 600)
        backgroundView.backgroundColor = .black
        scrollView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
        
        let dialogViewWidth = frame.width - 48
     
        let constraints = [
            
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            dialogView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            dialogView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            dialogView.widthAnchor.constraint(equalTo: widthAnchor, constant: -48),
            dialogView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            dialogView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: dialogView.topAnchor, constant: 32),
            titleLabel.centerXAnchor.constraint(equalTo: dialogView.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: dialogViewWidth - 48),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.centerXAnchor.constraint(equalTo: dialogView.centerXAnchor),
            messageLabel.widthAnchor.constraint(equalToConstant: dialogViewWidth - 48),
            
            textField.topAnchor.constraint(equalTo: withMessage ? messageLabel.bottomAnchor : titleLabel.bottomAnchor, constant: 16),
            textField.centerXAnchor.constraint(equalTo: dialogView.centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: dialogViewWidth - 48),
            textField.heightAnchor.constraint(equalToConstant: 48),
            
            textField2.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
            textField2.centerXAnchor.constraint(equalTo: dialogView.centerXAnchor),
            textField2.widthAnchor.constraint(equalToConstant: dialogViewWidth - 48),
            textField2.heightAnchor.constraint(equalToConstant: 48),
            
            leftActionButton.topAnchor.constraint(equalTo: with2TextFields ? textField2.bottomAnchor : textField.bottomAnchor, constant: 24),
            leftActionButton.leadingAnchor.constraint(equalTo: dialogView.leadingAnchor),
            leftActionButton.widthAnchor.constraint(equalToConstant: dialogViewWidth/2),
            leftActionButton.heightAnchor.constraint(equalToConstant: 56),
            
            rightActionButton.topAnchor.constraint(equalTo: leftActionButton.topAnchor),
            rightActionButton.trailingAnchor.constraint(equalTo: dialogView.trailingAnchor),
            rightActionButton.widthAnchor.constraint(equalToConstant: dialogViewWidth/2),
            rightActionButton.heightAnchor.constraint(equalToConstant: 56),
            rightActionButton.bottomAnchor.constraint(equalTo: dialogView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
   
}

// MARK: - Details

private extension CustomAlert {

    @objc private func didCancel() {
        endEditing(true)
        dismiss(animated: true)
    }

    @objc private func didEnter() {
        
        if let email = textField.text?.trimmingCharacters(in: .whitespaces),
           let passw = textField2.text?.trimmingCharacters(in: .whitespaces) {
            if isFirstPasswordEntry {
                enteredEmail = email
                enteredPassword = passw
                
                textField2.text = nil
                textField2.becomeFirstResponder()
                messageLabel.text = "Please confirm password"
                textField2.placeholder = "Enter password again"
                isFirstPasswordEntry = false
            } else {
                if enteredEmail == email {
                    if enteredPassword == passw {
                        didEnterHandler?(email, passw)
//                        dismiss(animated: true)
                    } else {
                        textField2.text = nil
                        textField2.becomeFirstResponder()
                        messageLabel.text = "Oops,\nplease confirm password"
                        textField2.placeholder = "Enter password again"
                        isFirstPasswordEntry = false
                    }
                }
            }
        }
    }

    @objc private func text1Entered() {
        titleLabel.text = "Create new account"
        isFirstPasswordEntry = true
        
        let rawEmail = textField.text?.trimmingCharacters(in: .whitespaces)
        
        if Checker.isValidEmail(email: rawEmail) {
            validEmailFlag = true
            messageLabel.text = "Enter strong password \nwith at least 6 characters, \none uppercase \nand one digit"
            textField2.isEnabled = true
            textField.rightViewMode = .always
        } else {
            messageLabel.text = "Please enter valid email"
            textField2.isEnabled = false
            textField.rightViewMode = .never
            return
        }
    }
    
    @objc private func text2Entered() {
        titleLabel.text = "Create new account"
        
        let rawPassword = textField2.text?.trimmingCharacters(in: .whitespaces)
        
        if Checker.isValidPassword(testStr: rawPassword) && validEmailFlag {
            rightActionButton.isEnabled = true
            if isFirstPasswordEntry {
                textField2.rightViewMode = .always
            } else {
                if enteredPassword == rawPassword {
                    textField2.rightViewMode = .always
                }
            }
        } else {
            rightActionButton.isEnabled = false
            textField2.rightViewMode = .never
        }
    }
    
    // dismissing alert by swiping down
    @objc private func handleDismiss(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            viewTranslation = sender.translation(in: self)
            endEditing(true)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
                self.backgroundView.alpha = 0.5 - self.viewTranslation.y / 500
            })
        case .ended:
            if viewTranslation.y < 200 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.transform = .identity
                    self.backgroundView.alpha = 0.5
                })
            } else {
                dismiss(animated: true)
            }
        default:
            break
        }
    }
}

