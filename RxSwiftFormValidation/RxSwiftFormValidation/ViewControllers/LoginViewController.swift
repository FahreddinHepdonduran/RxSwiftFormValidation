//
//  LoginViewController.swift
//  RxSwiftFormValidation
//
//  Created by fahreddin on 1.10.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    
    private lazy var emailTexField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    
    private lazy var passwordTexField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    
    private lazy var loginpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.isEnabled = false
        button.alpha = loginButtonInvalidFormAlphaValue
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = stackViewSpacing
        return stackView
    }()
    
    private let loginButtonInvalidFormAlphaValue: CGFloat = 0.5
    private let loginButtonValidFormAlphaValue: CGFloat = 1.0
    private let stackViewSpacing: CGFloat = 20.0
    private let stackViewTopConstraintConstant: CGFloat = 60.0
    private let stackViewLeadingConstraintConstant: CGFloat = 10.0
    private let stackViewTrailingConstraintConstant: CGFloat = -10.0
    private let textFieldsHeightConstant: CGFloat = 40.0
    private let loginButtonHeightConstant: CGFloat = 50.0
    
    private let viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Login"
        navigationController?.navigationBar.isHidden = false
        setupViews()
        setupBindings()
    }
    
    private func setupViews() {
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: stackViewTopConstraintConstant),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: stackViewLeadingConstraintConstant),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: stackViewTrailingConstraintConstant)
        ])
        
        stackView.addArrangedSubview(emailTexField)
        stackView.addArrangedSubview(passwordTexField)
        stackView.addArrangedSubview(loginpButton)
        
        emailTexField.heightAnchor.constraint(equalToConstant: textFieldsHeightConstant).isActive = true
        passwordTexField.heightAnchor.constraint(equalTo: emailTexField.heightAnchor).isActive = true
        loginpButton.heightAnchor.constraint(equalToConstant: loginButtonHeightConstant).isActive = true
    }

}

extension LoginViewController {
    
    func setupBindings() {
        emailTexField.rx.text.bind(to: viewModel.emailSubject).disposed(by: disposeBag)
        passwordTexField.rx.text.bind(to: viewModel.passwordSubject).disposed(by: disposeBag)
        
        viewModel.isValidForm.bind(to: loginpButton.rx.isEnabled).disposed(by: disposeBag)
        
        viewModel.isValidForm.subscribe (onNext: { [weak self] flag in
            guard let self = self else {return}
            self.loginpButton.alpha = flag ? self.loginButtonValidFormAlphaValue : self.loginButtonInvalidFormAlphaValue
        }).disposed(by: disposeBag)

    }
    
}
