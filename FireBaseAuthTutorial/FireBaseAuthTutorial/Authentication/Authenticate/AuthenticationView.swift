//
//  AuthenticationView.swift
//  FireBaseAuthTutorial
//
//  Created by Kunal Kumar R on 28/08/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift


struct AuthenticationView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            NavigationLink {
                SignInView(showSignInView: $showSignInView)
            } label: {
                Text("Sign In With Email")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            // Google SignIn Button
            GoogleSignInButton(scheme: .dark, style: .wide, state: .normal) {
                Task {
                    do {
                        try await viewModel.googleSignIn()
                        showSignInView = false
                    }catch {
                        print(error)
                    }
                }
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In")
    }
}

#Preview {
    NavigationStack {
        AuthenticationView(showSignInView: .constant(false))
    }
}
