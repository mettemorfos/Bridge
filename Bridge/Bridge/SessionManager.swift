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
        case accessError
    }
    
    @Published var session: sessionState = .loggedOut
    
    func login(email: String, password: String) {
        session = .authenticating
    }
    
    func authenticate(code: String) {
        if isValid(code) {
            session = .loggedIn
        } else {
            session = .accessError
        }
    }
    
    private func isValid(_ code: String) -> Bool {
        return !code.isEmpty
    }
}
