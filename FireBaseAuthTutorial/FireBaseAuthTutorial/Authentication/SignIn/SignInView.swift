//
//  SignInView.swift
//  FireBaseAuthTutorial
//
//  Created by Kunal Kumar R on 28/08/24.
//

import SwiftUI

struct SignInView: View {
    @Binding var showSignInView: Bool
    @StateObject private var viewModel = SignInViewModel()
    
    var body: some View {
        VStack {
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Button {
                Task {
                    // Sign Up
                    do {
                        try await viewModel.signUp()
                        showSignInView = false
                        return
                    }catch {
                        print(error.localizedDescription)
                    }
                    
                    // Sign In
                    do {
                        try await viewModel.signIn()
                        showSignInView = false
                        return
                    }catch {
                        print(error.localizedDescription)
                    }
                }
            }label: {
                Text("Sign In With Email")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Email Sign In")
    }
}

#Preview {
    NavigationStack {
        SignInView(showSignInView: .constant(false))
    }
}
