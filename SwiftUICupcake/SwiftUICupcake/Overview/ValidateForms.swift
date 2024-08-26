//
//  ValidateForms.swift
//  SwiftUICupcake
//
//  Created by Kunal Kumar R on 22/08/24.
//

import SwiftUI

struct ValidateForms: View {
    @State private var username = ""
    @State private var email = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account")
                }
            }
            .disabled(username.isEmpty || email.isEmpty)
        }
    }
}

#Preview {
    ValidateForms()
}
