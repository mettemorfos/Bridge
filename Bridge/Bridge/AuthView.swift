//
//  AuthView.swift
//  Bridge
//
//  Created by Mette Broegaard on 2025-12-19.
//

import SwiftUI
import WebKit

struct AuthView: View {
    
    @State private var viewModel: AuthViewModel
    
    init(sessionManager: SessionManager) {
        _viewModel = State(wrappedValue: AuthViewModel(sessionManager: sessionManager))
    }
    
    var body: some View {
        
        Group {
            if let page = viewModel.page {
                
                WebView(page)
                    .onChange(of: page.isLoading, initial: true, {
                        if !page.isLoading {
                            viewModel.injectContent()
                        }
                    })
            } else {
                Text("Waiting...")
            }
        }
        .onAppear() {
            viewModel.setup()
        }
    }
}

#Preview {
    AuthView(sessionManager: SessionManager())
}


