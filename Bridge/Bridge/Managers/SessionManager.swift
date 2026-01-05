//
//  SessionManager.swift
//  Bridge
//
//  Created by Mette Broegaard on 2025-12-19.
//

import Foundation
import SwiftUI

@MainActor
@Observable final class SessionManager {
    
    enum sessionState {
        case loggedIn
        case loggedOut
        case authenticating
        case accessError
    }
    
    var session: sessionState = .loggedOut
    var userName: String?
    
    func login(email: String, password: String) {
        guard isValidUser(email: email, password: password) else {
            return
        }
        userName = email
        session = .authenticating
    }
    
    func authenticate(code: String) {
        if isValidCode(code) {
            session = .loggedIn
        } else {
            session = .accessError
        }
    }
    
    private func isValidUser(email: String, password: String) -> Bool {
        //proper check of user credentials would go here
        return !email.isEmpty && !password.isEmpty
    }
    
    private func isValidCode(_ code: String) -> Bool {
        //proper check of code would go here
        return !code.isEmpty
    }
}
