//
//  AuthViewModel.swift
//  Bridge
//
//  Created by Mette Broegaard on 2026-01-02.
//

import Foundation
import SwiftUI
import WebKit

@MainActor
@Observable final class AuthViewModel: NSObject {
    
    var page: WebPage?
    let sessionManager: SessionManager
    private let messageName = "authHandler"
    private var navigationDecider = NavigationDecider()
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    func setup() {
        configureWebPage()
        loadContent()   
    }
    
    func injectContent() {
        guard let page, let name = sessionManager.userName else { return }
        
        let myValue = "Sign-in as \(name)"
        let script = """
                    
                    document.getElementById('userInfo').innerHTML = "\(myValue)";
                    
                    document.getElementById('submit').addEventListener('click', myFunction, false);
                    
                    function myFunction() {
                            let temp = document.getElementById("input").value;
                            window.webkit.messageHandlers.authHandler.postMessage({
                                                       "param1": "a value",
                                                       "param2": "another value",
                                                       "code": temp
                                                   });
                    }
                    
                    """
        
        Task {
            do {
                try await page.callJavaScript(script)
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
        configuration.userContentController.add(self, name: messageName)
        
        let page = WebPage(configuration: configuration, navigationDecider: self.navigationDecider)
        
        self.page = page
    }
    
    private func loadContent() {
        guard let url = Bundle.main.url(forResource: "authpage", withExtension: "html") else { return }
        guard let htmlString = try? String(contentsOf: url, encoding: .utf8) else { return }
        
        page?.load(html: htmlString)
    }
    
    private class NavigationDecider: WebPage.NavigationDeciding {
        func decidePolicy(for action: WebPage.NavigationAction, preferences: inout WebPage.NavigationPreferences) async -> WKNavigationActionPolicy {
            //checking that only trusted url:s are loaded could be done here
            return .allow
        }
    }
}

extension AuthViewModel: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard message.name == self.messageName else { return }
        
        if let code = getCode(data: message.body) {
            sessionManager.authenticate(code: code)
        }
    }
    
    private func getCode(data: Any) -> String? {
        guard let json = data as? [String: Any] else {
            return nil
        }
        
        return json["code"] as? String
    }
}

