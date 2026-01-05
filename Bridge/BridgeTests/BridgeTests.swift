//
//  BridgeTests.swift
//  BridgeTests
//
//  Created by Mette Broegaard on 2026-01-05.
//

import Testing
@testable import Bridge

struct BridgeTests {

    
    @Test func testEmailValidation() async throws {
        let model = await LoginViewModel(sessionManager: SessionManager())
        
        let validInput = "name@domain.com"
        var isvalid = await model.isValidEmail(validInput)
        #expect(isvalid)
        
        let notValidInput = "notanemail"
        isvalid = await model.isValidEmail(notValidInput)
        #expect(!isvalid)
    }
    
    @Test func testLogin() async throws {
        let sessionManager = await SessionManager()
        
        let email = "name@domain.com"
        
        let emptyPassword = ""
        
        await sessionManager.login(email: email, password: emptyPassword)
        
        var state = await sessionManager.session
        #expect(state == .loggedOut)
        
        let okPassword = "password"
        await sessionManager.login(email: email, password: okPassword)
        state = await sessionManager.session
        #expect(state == .authenticating)
    }
    
    @Test func testAuthentication() async throws {
        let sessionManager = await SessionManager()
        
        let code = "1234"
        await sessionManager.authenticate(code: code)
        var state = await sessionManager.session
        #expect(state == .loggedIn)
        
        let notACode = ""
        await sessionManager.authenticate(code: notACode)
        state = await sessionManager.session
        #expect(state == .accessError)
    }

}
