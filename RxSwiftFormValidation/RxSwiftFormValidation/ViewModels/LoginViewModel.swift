//
//  LoginViewModel.swift
//  RxSwiftFormValidation
//
//  Created by fahreddin on 1.10.2022.
//

import RxSwift
import RxCocoa

final class LoginViewModel {
    
    let emailSubject = BehaviorRelay<String?>(value: "")
    let passwordSubject = BehaviorRelay<String?>(value: "")
    
    let minPasswordCharacterCount: Int = 5
    
    var isValidForm: Observable<Bool> {
        return Observable.combineLatest(emailSubject, passwordSubject) { [weak self] email, password in
            guard let self = self, let email = email, let password = password else {
                return false
            }
            
            return email.isValidEmail && password.count >= self.minPasswordCharacterCount
        }
    }
    
    init() { }
    
}
