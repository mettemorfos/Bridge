//
//  SessionManager.swift
//  Bridge
//
//  Created by Mette Broegaard on 2025-12-19.
//

import Foundation
import Combine

class SessionManager: ObservableObject {
    
    enum sessionState {
        case loggedIn
        case loggedOut
        case authenticating
    }
    
    @Published var session: sessionState = .loggedOut
    
    func login(email: String, password: String) {
        session = .authenticating
    }
    
    func authenticate() {
        session = .loggedIn
    }
    
    
}
