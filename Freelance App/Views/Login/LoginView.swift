//
//  LoginScreen.swift
//  Freelance App
//
//  Created by Evan Richard on 7/13/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var loginVM: LoginViewModel
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loading = false
    @State private var isError = false
    @State private var isSignUp = false
    
    var body: some View {
        ZStack {
            if (!isSignUp) {
                VStack {
                    Spacer()
                    Button(action: switchActions) {
                        Text("Don't have an account? Sign up!")
                    }
                }
            } else {
                VStack {
                    Spacer()
                    Button(action: switchActions) {
                        Text("Already have an account? Sign in!")
                    }
                }
            }
            VStack(alignment: .center, spacing: 60) {
                Text("App Name")
                    .font(.largeTitle)
                VStack(alignment: .trailing, spacing: 12) {
                    VStack(alignment: .center, spacing: 15) {
                        if isSignUp {
                            TextField("Full Name", text: $name)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .textFieldStyle(ReplyTextFieldStyle(isError: isError && name == ""))
                        }
                        TextField("Email", text: $email)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .textFieldStyle(ReplyTextFieldStyle(isError: isError && email == ""))
                        SecureField("Password", text: $password)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .textFieldStyle(ReplyTextFieldStyle(isError: isError && password == ""))
                    }
                    if !isSignUp {
                        Button(action: {}) {
                            Text("Forgot your password?")
                        }
                    }
                }
                VStack(alignment: .center, spacing: 20) {
                    Button(action: isSignUp ? signUp : signIn) {
                        Text(isSignUp ? "Register" : "Sign In")
                            .foregroundColor(Color.white)
                            .fontWeight(.semibold)
                            .padding()
                            .padding(.horizontal, 40)
                            .shadow(radius: 10)
                    }
                    .background(
                        RadialGradientStyle(accentColor: Color(.systemBlue))
                    )
                    .cornerRadius(30)
                    if (isError) {
                        if (email == "" || password == "" || (isSignUp && name == "")) {
                            Text("Please enter all required fields.")
                                .foregroundColor(ThemeConstants.DANGER_COLOR)
                        } else {
                            Text("Failed to authenticate. Please try again.")
                                .foregroundColor(ThemeConstants.DANGER_COLOR)
                        }
                    }
                }
            }
        }
        .padding()
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.secondarySystemBackground))
        .edgesIgnoringSafeArea(.all)
    }
    
    private func clearFields() {
        withAnimation {
            isError = false
        }
        self.name = ""
        self.email = ""
        self.password = ""
    }
    
    private func switchActions() {
        withAnimation {
            isSignUp.toggle()
        }
        clearFields()
    }
    
    private func signUp() {
        withAnimation {
            loading = true
            if (name == "" || email == "" || password == "") {
                isError = true
            } else {
                isError = false
            }
        }
        if !isError {
            loginVM.signUp(email: email, password: password, name: name) { (result, error) in
                self.loading = false
                if error != nil {
                    withAnimation {
                        self.isError = true
                    }
                } else {
                    self.clearFields()
                }
            }
        }
        hideKeyboard()
    }
    
    private func signIn() {
        withAnimation {
            loading = true
            if (email == "" || password == "") {
                isError = true
            } else {
                isError = false
            }
        }
        if !isError {
            loginVM.signIn(email: email, password: password) { (result, error) in
                self.loading = false
                if error != nil {
                    withAnimation {
                        self.isError = true
                    }
                } else {
                    self.clearFields()
                }
            }
        }
        hideKeyboard()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginVM: LoginViewModel())
    }
}
