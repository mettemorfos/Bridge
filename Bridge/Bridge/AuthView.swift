//
//  AuthView.swift
//  Bridge
//
//  Created by Mette Broegaard on 2025-12-19.
//

import SwiftUI
import WebKit

struct AuthView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State private var page: WebPage?
    private let datastore: WKWebsiteDataStore = .nonPersistent()
    var body: some View {
        
        Group {
            if let page {
                WebView(page)
            } else {
                Text("Waiting")
            }
        }
        .onAppear() {
            initWebpage()
            loadContents()
        }
        
        
    }
    
    func initWebpage() {
            var configuration = WebPage.Configuration()
            
            var navigationPreference = WebPage.NavigationPreferences()
            
            navigationPreference.allowsContentJavaScript = true
            navigationPreference.preferredHTTPSNavigationPolicy = .errorOnFailure
            navigationPreference.preferredContentMode = .recommended
            configuration.defaultNavigationPreferences = navigationPreference
            
            configuration.websiteDataStore = self.datastore
            
            configuration.applicationNameForUserAgent = "AuthView"
            
            let page = WebPage(configuration: configuration)
            
            self.page = page
            
        }
        
        func loadContents() {
            guard let url = Bundle.main.url(forResource: "authpage", withExtension: "html") else { return }
            guard let htmlString = try? String(contentsOf: url, encoding: .utf8) else { return }
            
            page?.load(html: htmlString)
        }

}

#Preview {
    AuthView()
}
