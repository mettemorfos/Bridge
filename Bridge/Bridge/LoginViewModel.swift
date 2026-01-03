//
//  LoginViewModel.swift
//  Bridge
//
//  Created by Mette Broegaard on 2026-01-03.
//

import Foundation
import SwiftUI

@MainActor
@Observable final class LoginViewModel {
    
    let sessionManager: SessionManager
    var email: String = ""
    var password: String = ""
    var showError: Bool = false
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    func attemptLogin() {
        guard !email.isEmpty, !password.isEmpty else {
            showError = true
            return
        }
        
        guard isValidEmail(email) else {
            showError = true
            return
        }
        
        sessionManager.login(email: email, password: password)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
}
