//
//  LoginView.swift
//  Bridge
//
//  Created by Mette Broegaard on 2025-12-19.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        Text("Enter your credentials here:")
        VStack(spacing: 15) {
            TextField("Email", text: .constant(""))
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            SecureField("Password", text: .constant(""))
        }
        .padding(20)
        Button("Log in") {
            sessionManager.login()
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(SessionManager())
}
