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
        userName = email
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
