//
//  RegistrationViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 15/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

protocol RegistrationDisplayable {
    func displayContent(_ viewModel: Registration.Content.ViewModel)
    func displayLogin(_ viewModel: Registration.Success.ViewModel)
    func displayFailure(_ viewModel: Registration.Failure.ViewModel)
}

final class RegistrationViewController: ViewController {
    // MARK: External properties
    var interactor: RegistrationLogic?
    
    // MARK: Private properties
    private var emailTextField = TextField()
    private var passwordTextField = TextField()
    private var repeatedPasswordTextField = TextField()
    private var registerButton = Button()
    
    private var registerMethodsLabel = UILabel()
    private var registerMethodsContainer = UIStackView()
    private var facebookRegisterButton = Button()
    private var googleRegisterButton = Button()
    private var appleRegisterButton = Button()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getContent()
    }
}

// MARK: RegistrationDisplayable
extension RegistrationViewController: RegistrationDisplayable {
    func displayContent(_ viewModel: Registration.Content.ViewModel) {}
    
    func displayLogin(_ viewModel: Registration.Success.ViewModel) {
        displayNotification(.success, with: "Successful register")
        routeToPreviousScreen()
    }
    
    func displayFailure(_ viewModel: Registration.Failure.ViewModel) {
        displayNotification(.failure, with: "Please try again")
    }
}

// MARK: External methods
extension RegistrationViewController {
    func getContent() {
        interactor?.getContent(.init())
    }
}

// MARK: Events
private extension RegistrationViewController {
    @objc func tapRegisterButton() {
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
        
        guard let repeatedPassword = repeatedPasswordTextField.text, password == repeatedPassword else {
            displayNotification(.failure, with: "Same passwords required")
            return
        }
        
        displayLoader()
        interactor?.register(.init(type: .email(email: email, password: password)))
    }
    
    @objc func tapFacebookButton() {
        interactor?.register(.init(type: .facebook))
    }
    
    @objc func tapGoogleButton() {
        interactor?.register(.init(type: .google))
    }
    
    @objc func tapAppleButton() {
        interactor?.register(.init(type: .apple))
    }
}

// MARK: Private methods
private extension RegistrationViewController {
    func setupView() {
        setup(title: "Registration")
        setupBackButton()
        setupStackView()
        setupElements()
        setupHiddenKeyboard()
    }
    
    func setupElements() {
        [emailTextField, passwordTextField, repeatedPasswordTextField, registerButton, registerMethodsLabel, registerMethodsContainer].forEach {
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
        setupRepeatPasswordTextField()
        setupRegisterButton()
        setupRegisterMethodsLabel()
        setupRegisterMethodsContainer()
    }
    
    func setupEmailTextField() {
        emailTextField.setupPlaceholder("Email")
    }
    
    func setupPasswordTextField() {
        passwordTextField.setupPlaceholder("Password")
//        passwordTextField.isSecureTextEntry = true
    }
    
    func setupRepeatPasswordTextField() {
        repeatedPasswordTextField.setupPlaceholder("Repeat password")
//        repeatPasswordTextField.isSecureTextEntry = true
    }
    
    func setupRegisterButton() {
        registerButton.setup(for: .enable, with: "Register")
        registerButton.addTarget(self, action: #selector(tapRegisterButton), for: .touchUpInside)
    }

    func setupRegisterMethodsLabel() {
        registerMethodsLabel.text = "or register with"
        registerMethodsLabel.font = Font.normalSemiBold
        registerMethodsLabel.textColor = Color.gray
        registerMethodsLabel.textAlignment = .center
    }
    
    func setupRegisterMethodsContainer() {
        [facebookRegisterButton, googleRegisterButton, appleRegisterButton].forEach {
            registerMethodsContainer.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        registerMethodsContainer.distribution = .fillEqually
        registerMethodsContainer.spacing = Margin.small.space
        
        setupFacebookRegisterButton()
        setupGoogleRegisterButton()
        setupAppleRegisterButton()
    }
    
    func setupFacebookRegisterButton() {
        facebookRegisterButton.setup(for: .borderedImage, and: Image.iconFacebook)
        facebookRegisterButton.addTarget(self, action: #selector(tapFacebookButton), for: .touchUpInside)
    }
    
    func setupGoogleRegisterButton() {
        googleRegisterButton.setup(for: .borderedImage, and: Image.iconGoogle)
        googleRegisterButton.addTarget(self, action: #selector(tapGoogleButton), for: .touchUpInside)
    }
    
    func setupAppleRegisterButton() {
        appleRegisterButton.setup(for: .borderedImage, and: Image.iconApple)
        appleRegisterButton.addTarget(self, action: #selector(tapAppleButton), for: .touchUpInside)
    }
}
