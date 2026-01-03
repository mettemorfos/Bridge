//
//  BridgeApp.swift
//  Bridge
//
//  Created by Mette Broegaard on 2025-12-19.
//

import SwiftUI

@main
struct BridgeApp: App {
    
    @State var sessionManager: SessionManager = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            switch sessionManager.session {
            case .loggedOut:
                LoginView(sessionManager: sessionManager)
            case .authenticating:
                AuthView(sessionManager: sessionManager)
            case .loggedIn:
                ContentView()
            case .accessError:
                ErrorView()
            }
        }
    }
}
