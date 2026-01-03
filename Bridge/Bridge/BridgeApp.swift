//
//  BridgeApp.swift
//  Bridge
//
//  Created by Mette Broegaard on 2025-12-19.
//

import SwiftUI

@main
struct BridgeApp: App {
    
    @StateObject var sessionManager: SessionManager = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            switch sessionManager.session {
            case .loggedOut:
                LoginView()
            case .authenticating:
                AuthView(sessionManager: sessionManager)
            case .loggedIn:
                ContentView()
            case .accessError:
                ErrorView()
            }
        }
        .environmentObject(sessionManager)
    }
}
