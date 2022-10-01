//
//  ViewController.swift
//  RxSwiftFormValidation
//
//  Created by fahreddin on 1.10.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = loginButtonBorderWith
        button.layer.borderColor = UIColor.blue.cgColor
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
    
    private let loginButtonBorderWith: CGFloat = 1.0
    private let stackViewSpacing: CGFloat = 20.0
    private let stackViewLeadingConstraintConstant: CGFloat = 10.0
    private let stackViewBottomConstraintConstant: CGFloat = -60.0
    private let stackViewTrailingConstraintConstant: CGFloat = -10.0
    private let buttonsHeightCosntant: CGFloat = 50.0
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setupViews()
        bindButtonTaps()
    }
    
    private func setupViews() {
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: stackViewLeadingConstraintConstant),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: stackViewBottomConstraintConstant),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: stackViewTrailingConstraintConstant)
        ])
        
        stackView.addArrangedSubview(signUpButton)
        stackView.addArrangedSubview(loginButton)
        signUpButton.heightAnchor.constraint(equalToConstant: buttonsHeightCosntant).isActive = true
        loginButton.heightAnchor.constraint(equalTo: signUpButton.heightAnchor).isActive = true
    }
    
}

extension ViewController {
    
    func bindButtonTaps() {
        signUpButton.rx.tap.bind { [weak self] in
            self?.signUpAction()
        }.disposed(by: disposeBag)
        
        loginButton.rx.tap.bind { [weak self] in
            self?.loginAction()
        }.disposed(by: disposeBag)
    }
    
    func signUpAction() {
        let signUpViewController = SignUpViewController()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    func loginAction() {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
}
