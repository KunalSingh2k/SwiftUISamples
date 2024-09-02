//
//  SettingsViewModel.swift
//  FireBaseAuthTutorial
//
//  Created by Kunal Kumar R on 28/08/24.
//

import Foundation


final class SettingsViewModel: ObservableObject {
    @Published var authProviders: [AuthProviderOption] = []
    
    func loadAuthProviders() {
        if let provider = try? AuthenticationManager.shared.getProviders() {
            authProviders = provider
        }
    }
    
    var authenticationManager: AuthenticationManager {
        AuthenticationManager.shared
    }
    
    // Sign out
    func signOut() throws {
        try authenticationManager.signOut()
    }
    
    // Reset Password
    func resetPassword() async throws {
        let user = try authenticationManager.getAuthenticatedUser()
        
        guard let email = user.email else {
            print("error fetching email")
            return
        }
        
        try await authenticationManager.resetPassword(email: email)
    }
    
    // Update password
    func updatePassword() async throws {
        let password = "1234567*"
        try await authenticationManager.updatePassword(password: password)
    }
    
    func updateEmail() async throws {
        let email = "updatedemail@testing.com"
        try await authenticationManager.updateEmail(email: email)
    }
}
