//
//  AuthView.swift
//  Bridge
//
//  Created by Mette Broegaard on 2025-12-19.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var sessionManager: SessionManager
    var body: some View {
        Text("Authenticate")
        Button("Submit") {
            sessionManager.authenticate()
        }
    }
}

#Preview {
    AuthView()
}
