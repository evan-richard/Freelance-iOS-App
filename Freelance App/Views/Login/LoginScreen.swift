//
//  LoginScreen.swift
//  Freelance App
//
//  Created by Evan Richard on 7/13/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct LoginScreen: View {
    @ObservedObject var loginVM: LoginViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loading = false
    @State private var error = false

    func signIn () {
        loading = true
        error = false
        loginVM.signIn(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            } else {
                self.email = ""
                self.password = ""
            }
        }
        hideKeyboard()
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            VStack(alignment: .center, spacing: 15) {
                TextField("Email", text: $email)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color(.systemFill))
                    .cornerRadius(30)
                SecureField("Password", text: $password)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color(.systemFill))
                    .cornerRadius(30)
            }
            VStack(alignment: .center, spacing: 10) {
                Button(action: signIn) {
                    Text("Sign in")
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                        .padding()
                        .padding(.horizontal, 40)
                        .shadow(radius: 10)
                }
                .background(Color(.purple))
                .cornerRadius(30)
                if (error) {
                    Text("Failed to authenticate. Please try again.")
                        .foregroundColor(.red)
                }
            }
        }
        .padding()
        .padding(.horizontal, 40)
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(loginVM: LoginViewModel())
    }
}
