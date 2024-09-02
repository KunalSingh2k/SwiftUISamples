//
//  SettingsView.swift
//  FireBaseAuthTutorial
//
//  Created by Kunal Kumar R on 28/08/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            // SignOut Button
            Button("Signout") {
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            if viewModel.authProviders.contains(.email) {
                emailSection
            }
        }
        .onAppear {
            viewModel.loadAuthProviders()
        }
        .navigationTitle("Settings")
    }
}

//MARK: - Preview
#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(false))
    }
}


extension SettingsView {
    private var emailSection: some View {
        Section {
            // Reset Password Button
            Button("Reset Password") {
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("Password reset successful..")
                        showSignInView = true
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
            // Update Password Button
            Button("Update Password") {
                Task {
                    do {
                        try await viewModel.updatePassword()
                        print("Password updated successfully..")
                        showSignInView = true
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
            // Update Email Button
            /// needs to be checked - not updating the email
            Button("Update Email") {
                Task {
                    do {
                        try await viewModel.updateEmail()
                        print("Email updated successfully..")
                        showSignInView = true
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
        } header: {
            Text("Email Functions")
        }
    }
}
