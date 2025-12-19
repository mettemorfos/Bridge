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
        Text("Log in")
        Button("Log in") {
            sessionManager.login()
        }
    }
}

#Preview {
    LoginView()
}
