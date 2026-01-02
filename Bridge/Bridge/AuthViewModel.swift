//
//  AuthViewModel.swift
//  Bridge
//
//  Created by Mette Broegaard on 2026-01-02.
//

import SwiftUI
import WebKit

@MainActor
@Observable final class AuthViewModel: NSObject {
    
    var page: WebPage?
    
    let sessionManager: SessionManager
    
    init (sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    func setup() {
        configureWebPage()
        loadContent()   
    }
    
    func injectContent() {
        guard let page else { return }
        let myValue = "Value from session: xxx"
        let snippet = """
                    document.getElementById('userInfo').innerHTML = "\(myValue)";
                    """
        
        Task {
            do {
                try await page.callJavaScript(snippet)
            } catch {
                print("Error calling JavaScript: \(error)")
            }
        }
    }
    
    private func configureWebPage() {
        var configuration = WebPage.Configuration()
        var navigationPreference = WebPage.NavigationPreferences()
        
        navigationPreference.allowsContentJavaScript = true
        navigationPreference.preferredHTTPSNavigationPolicy = .errorOnFailure
        navigationPreference.preferredContentMode = .recommended
        configuration.defaultNavigationPreferences = navigationPreference
        configuration.userContentController.add(self, name: "authHandler")
    
        let page = WebPage(configuration: configuration)
        
        self.page = page
    }
    
    private func loadContent() {
        guard let url = Bundle.main.url(forResource: "authpage", withExtension: "html") else { return }
        guard let htmlString = try? String(contentsOf: url, encoding: .utf8) else { return }
        
        page?.load(html: htmlString)
    }
    
}

extension AuthViewModel: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("Received: \(message.body)")
        sessionManager.authenticate()
    }
    
    
}



