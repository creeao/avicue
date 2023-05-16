//
//  LoginViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 29/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

protocol LoginDisplayable {
    func displayContent(_ viewModel: Login.Content.ViewModel)
    func displayDashboard(_ viewModel: Login.Success.ViewModel)
    func displayFailure(_ viewModel: Login.Failure.ViewModel)
}

final class LoginViewController: ViewController {
    // MARK: External properties
    var interactor: LoginLogic?
    
    // MARK: Private properties
    private var emailTextField = TextField()
    private var passwordTextField = TextField()
    private let buttonsView = ButtonsView()
    
    private var loginMethodsLabel = UILabel()
    private var loginMethodsContainer = UIStackView()
    private var facebookLoginButton = Button()
    private var googleLoginButton = Button()
    private var appleLoginButton = Button()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getContent()
    }
}

// MARK: LoginDisplayable
extension LoginViewController: LoginDisplayable {
    func displayContent(_ viewModel: Login.Content.ViewModel) {}

    func displayDashboard(_ viewModel: Login.Success.ViewModel) {
        displayNotification(.success, with: "Successful login")
        let viewController = TabBarController()
        push(viewController)
    }
    
    func displayFailure(_ viewModel: Login.Failure.ViewModel) {
        displayNotification(.failure, with: "Wrong email or password")
    }
}

// MARK: ButtonsViewDelegate
extension LoginViewController: ButtonsViewDelegate {
    func tapFirstButton() {
        guard let email = emailTextField.text, !email.isEmpty else {
            displayNotification(.failure, with: "Enter your email")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            displayNotification(.failure, with: "Enter your password")
            return
        }
        
        guard password.count >= 6 else {
            displayNotification(.failure, with: "Password required 6 characters")
            return
        }
        
        displayLoader()
        interactor?.login(.init(type: .email(email: email, password: password)))
    }
    
    func tapSecondButton() {

    }
    
    func tapThirdButton() {
        let registrationViewController = Registration.createScene()
        push(registrationViewController)
    }
}

// MARK: External methods
extension LoginViewController {
    func getContent() {
        interactor?.getContent(.init())
    }
}


// MARK: Events
private extension LoginViewController {
    @objc func tapFacebookButton() {
        interactor?.login(.init(type: .facebook))
    }
    
    @objc func tapGoogleButton() {
        interactor?.login(.init(type: .google))
    }
    
    @objc func tapAppleButton() {
        interactor?.login(.init(type: .apple))
    }
}

// MARK: Private methods
private extension LoginViewController {
    func setupView() {
        setup(title: "Login")
        setupStackView()
        setupElements()
        setupHiddenKeyboard()
    }
    
    func setupElements() {
        [emailTextField, passwordTextField, buttonsView, loginMethodsLabel, loginMethodsContainer].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
                $0.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
            ])
        }
        
        setupEmailTextField()
        setupPasswordTextField()
        setupButtonsView()
        setupLoginMethodsLabel()
        setupLoginMethodsContainer()
    }
    
    func setupEmailTextField() {
        emailTextField.setupPlaceholder("Email")
        emailTextField.text = "k@k.com"
    }
    
    func setupPasswordTextField() {
        passwordTextField.setupPlaceholder("Password")
        passwordTextField.text = "123456"
        passwordTextField.isSecureTextEntry = true
    }
    
    func setupButtonsView() {
        buttonsView.setup(
            firstButtonTitle: "Login",
            secondButtonTitle: "Reset password",
            thirdButtonTitle: "Register")
        buttonsView.delegate = self
    }
    
    func setupLoginMethodsLabel() {
        loginMethodsLabel.text = "or login with"
        loginMethodsLabel.font = Font.normalSemiBold
        loginMethodsLabel.textColor = Color.gray
        loginMethodsLabel.textAlignment = .center
    }
    
    func setupLoginMethodsContainer() {
        [facebookLoginButton, googleLoginButton, appleLoginButton].forEach {
            loginMethodsContainer.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        loginMethodsContainer.distribution = .fillEqually
        loginMethodsContainer.spacing = Margin.small.space
        
        setupFacebookLoginButton()
        setupGoogleLoginButton()
        setupAppleLoginButton()
    }
    
    func setupFacebookLoginButton() {
        facebookLoginButton.setup(for: .borderedImage, and: Image.iconFacebook)
        facebookLoginButton.addTarget(self, action: #selector(tapFacebookButton), for: .touchUpInside)
    }
    
    func setupGoogleLoginButton() {
        googleLoginButton.setup(for: .borderedImage, and: Image.iconGoogle)
        googleLoginButton.addTarget(self, action: #selector(tapGoogleButton), for: .touchUpInside)
    }
    
    func setupAppleLoginButton() {
        appleLoginButton.setup(for: .borderedImage, and: Image.iconApple)
        appleLoginButton.addTarget(self, action: #selector(tapAppleButton), for: .touchUpInside)
    }
}
