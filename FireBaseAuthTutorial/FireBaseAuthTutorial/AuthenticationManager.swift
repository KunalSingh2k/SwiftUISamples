//
//  AuthenticationManager.swift
//  FireBaseAuthTutorial
//
//  Created by Kunal Kumar R on 28/08/24.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

enum AuthProviderOption: String {
    case email = "password"
    case google = "google.com"
}

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    private init() { }
    
    // Get Authenticated user method
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let authenticatedUser = Auth.auth().currentUser else {
            throw URLError(.unknown)
        }
        return AuthDataResultModel(user: authenticatedUser)
    }
    
    func getProviders() throws -> [AuthProviderOption] {
        guard let providerData = Auth.auth().currentUser?.providerData else {
            throw URLError(.unknown)
        }
        
        var providers: [AuthProviderOption] = []
        for provider in providerData {
            if let option = AuthProviderOption(rawValue: provider.providerID) {
                providers.append(option)
            }else {
                assertionFailure("Provider option not found \(provider.providerID)")
            }
        }
        return providers
    }
    
    // SignOut method
    func signOut() throws {
        try Auth.auth().signOut()
    }
}


//MARK: - SignIn with Email
extension AuthenticationManager {
    
    @discardableResult
    // SignUp method
    ///  Create a new user
    func signUpUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    @discardableResult
    // SignIn existing user
    /// If the user is already signed into the application
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
   
    // Reset Password Method
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    // Update Password method
    func updatePassword(password: String) async throws {
        guard let authenticatedUser = Auth.auth().currentUser else {
            print("No authenticated user found to update password")
            return
        }
        try await authenticatedUser.updatePassword(to: password)
    }
    
    // Update Email method
    func updateEmail(email: String) async throws {
        guard let authenticatedUser = Auth.auth().currentUser else {
            print("No authenticated user found to update password")
            return
        }
        try await authenticatedUser.sendEmailVerification(beforeUpdatingEmail: email)
    }
    
}

//MARK: - SignIn with SSO
extension AuthenticationManager {
    
    // SignIn
    func signIn(crendential: AuthCredential) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(with: crendential)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    // SignIn with google
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(crendential: credential)
    }
}

