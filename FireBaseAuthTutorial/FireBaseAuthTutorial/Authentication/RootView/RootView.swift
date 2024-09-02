//
//  RootView.swift
//  FireBaseAuthTutorial
//
//  Created by Kunal Kumar R on 28/08/24.
//

import SwiftUI

struct RootView: View {
    @State private var showSignInView = false
    
    var body: some View {
        ZStack {
            if !showSignInView {
                NavigationStack {
                    SettingsView(showSignInView: $showSignInView)
                }
            }
        }
        .onAppear {
            let authenticatedUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            showSignInView = authenticatedUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthenticationView(showSignInView: $showSignInView)
            }
        }
    }
}

#Preview {
    RootView()
}
