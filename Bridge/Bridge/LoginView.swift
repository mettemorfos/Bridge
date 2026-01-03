//
//  LoginView.swift
//  Bridge
//
//  Created by Mette Broegaard on 2025-12-19.
//

import SwiftUI

struct LoginView: View {
    
    @State var viewModel: LoginViewModel
    
    init(sessionManager: SessionManager) {
        _viewModel = State(wrappedValue: LoginViewModel(sessionManager: sessionManager))
    }
    
    var body: some View {
        Text("Enter your credentials here:")
        VStack(spacing: 15) {
            TextField("Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            SecureField("Password", text: $viewModel.password)
        }
        .padding(20)
        Button("Log in") {
            viewModel.attemptLogin()
        }
        if viewModel.showError {
            Text("Invalid email or password")
                .foregroundColor(.red)
        }
    }
    
    
}

#Preview {
    LoginView(sessionManager: SessionManager())
}
