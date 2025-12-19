//
//  LoginView.swift
//  Bridge
//
//  Created by Mette Broegaard on 2025-12-19.
//

import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var showError: Bool = false
    
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        Text("Enter your credentials here:")
        VStack(spacing: 15) {
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            SecureField("Password", text: $password)
        }
        .padding(20)
        Button("Log in") {
            attemptLogin()
        }
        if showError {
            Text("Invalid email or password")
                .foregroundColor(.red)
        }
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

#Preview {
    LoginView()
        .environmentObject(SessionManager())
}
