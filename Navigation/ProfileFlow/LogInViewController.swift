//
//  LogInViewController.swift
//  Navigation
//
//  Created by Alex Permiakov on 11/11/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    weak var coordinator: ProfileNavCoordinator?
   
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
        textField.keyboardType = .emailAddress
        textField.returnKeyType = UIReturnKeyType.continue
        textField.addTarget(self, action: #selector(logInTextEntered), for: .editingChanged)
        return textField
    }()
    
    private var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.logInProperties(placeholder: "Password")
        textField.isSecureTextEntry = true
        textField.returnKeyType = UIReturnKeyType.go
        textField.addTarget(self, action: #selector(passwordTextEntered), for: .editingChanged)
        textField.isEnabled = false
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
        button.isEnabled = false
        return button
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account yet?"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .light),
            .foregroundColor: UIColor(named: "blueVK") ?? .systemBlue,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        button.setAttributedTitle(
            NSMutableAttributedString(string: "Sign up", attributes: attributes),
            for: .normal)
        button.addTarget(self, action: #selector(onSignUp), for: .touchUpInside)
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Actions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == logInTextField {
            passwordTextField.becomeFirstResponder()
        }
        return true
    }
    
    @objc private func logInTextEntered(_ textField: UITextField) {
        if Checker.isValidEmail(email: logInTextField.text) {
            logInTextField.rightViewMode = .always
            loginIsEntered = true
            passwordTextField.isEnabled = true
        } else {
            logInTextField.rightViewMode = .never
            logInTextField.placeholder = "Login can't be empty!"
            logInTextField.becomeFirstResponder()
            passwordTextField.isEnabled = false
            logInButton.isEnabled = false
        }
    }
    
    @objc private func passwordTextEntered(_ textField: UITextField) {
        if let text = passwordTextField.text, text.count > 5 {
            passwordTextField.rightViewMode = .always
            passwordIsEntered = true
            if loginIsEntered {
                logInButton.isEnabled = true
            }
        } else {
            passwordTextField.rightViewMode = .never
            passwordTextField.placeholder = "Password can't be empty!"
            passwordTextField.becomeFirstResponder()
            logInButton.isEnabled = false
        }
    }
    
    @objc private func logInButtonAction() {
        if let login = logInTextField.text,
           let password = passwordTextField.text {
            
            Auth.auth().signIn(withEmail: login, password: password) { authResult, error in
                if let error = error {
                    print(error.localizedDescription)
                    let alert = CustomAlert(title: "Wrong credentials",
                                            message: "Register new account?\nTap cancel to try again",
                                            leftBtnTitle: "Cancel",
                                            rightBtnTitle: "Register",
                                            leftBtnColor: .systemRed,
                                            rightBtnColor: UIColor(named: "blueVK"),
                                            textFieldPlaceholder: "Enter email",
                                            textField2Placeholder: "Enter password",
                                            text: login)
                    alert.show(animated: true)
                    alert.didEnterHandler = { login, passw in
                        Auth.auth().createUser(withEmail: login, password: passw) { (authResult, error) in
                            if let error = error {
                                print(error.localizedDescription)
                            } else {
                                print("Created new user")
                            }
                        }
                    }
                    return
                }
                if let authResult = authResult {
                    print("logged in \(String(describing: authResult.user.email))")
                }
            }
        }
        
        passwordTextField.resignFirstResponder()
        logInTextField.resignFirstResponder()
    }
    
    @objc private func onSignUp() {
        let alert = CustomAlert(title: "Register new account.",
                                message: "Enter email and password",
                                leftBtnTitle: "Cancel",
                                rightBtnTitle: "Register",
                                leftBtnColor: .systemRed,
                                rightBtnColor: UIColor(named: "blueVK"),
                                textFieldPlaceholder: "Enter email",
                                textField2Placeholder: "Enter password",
                                text: nil)
        alert.show(animated: true)
        alert.didEnterHandler = { login, passw in
            Auth.auth().createUser(withEmail: login, password: passw) { (authResult, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Created new user")
                }
            }
        }
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
        contentView.addSubview(infoLabel)
        contentView.addSubview(signUpButton)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        logoVKImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(120)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        logInTextField.snp.makeConstraints {
            $0.height.equalTo(50.5)
        }
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        stackView.snp.makeConstraints {
            $0.top.equalTo(logoVKImage.snp_bottom).offset(120)
            $0.left.equalToSuperview().offset(baseInset)
            $0.right.equalToSuperview().offset(-baseInset)
        }
        logInButton.snp.makeConstraints {
            $0.top.equalTo(stackView.snp_bottom).offset(baseInset)
            $0.left.equalToSuperview().offset(baseInset)
            $0.right.equalToSuperview().offset(-baseInset)
            $0.height.equalTo(50)
        }
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(logInButton.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}


