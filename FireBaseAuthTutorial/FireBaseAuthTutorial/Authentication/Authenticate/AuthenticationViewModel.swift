//
//  AuthenticationViewModel.swift
//  FireBaseAuthTutorial
//
//  Created by Kunal Kumar R on 28/08/24.
//

import Foundation


@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    func googleSignIn() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
}
