//
//  SignInViewModel.swift
//  FireBaseAuthTutorial
//
//  Created by Kunal Kumar R on 28/08/24.
//

import Foundation

final class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found..")
            return
        }
        try await AuthenticationManager.shared.signUpUser(email: email, password: password)
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found..")
            return
        }
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}
