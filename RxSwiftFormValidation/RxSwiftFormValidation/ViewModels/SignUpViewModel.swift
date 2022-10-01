//
//  SignUpViewModel.swift
//  RxSwiftFormValidation
//
//  Created by fahreddin on 1.10.2022.
//

import RxSwift
import RxCocoa

final class SignUpViewModel {
    
    let nameSubject = BehaviorRelay<String?>(value: "")
    let emailSubject = BehaviorRelay<String?>(value: "")
    let passwordSubject = BehaviorRelay<String?>(value: "")
    
    let minNameCharacterCount: Int = 2
    let minPasswordCharacterCount: Int = 5
    
    var isValidForm: Observable<Bool> {
        return Observable.combineLatest(nameSubject, emailSubject, passwordSubject) { [weak self] name, email, password in
            guard let self = self, let name = name, let email = email, let password = password else {
                return false
            }
            
            return name.count >= self.minNameCharacterCount && email.isValidEmail
            && password.count >= self.minPasswordCharacterCount
        }
    }
    
    init() { }
    
}
