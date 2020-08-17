//
//  LoginViewModel.swift
//  Freelance App
//
//  Created by Evan Richard on 7/13/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import Combine

class LoginViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var id: String = ""
    @Published var displayName: String?
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.appDelegate.sessionStore.$session.sink{ user in
            if let authenticatedUser = user {
                self.id = authenticatedUser.id
                self.displayName = authenticatedUser.displayName
                self.isAuthenticated = true
                self.appDelegate.projectsStore.loadProjectsList(userId: authenticatedUser.id)
            } else {
                self.id = ""
                self.displayName = nil
                self.isAuthenticated = false
            }
        }
        .store(in: &cancellables)
    }
    
    func signUp(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
    ) {
        self.appDelegate.sessionStore.signUp(email: email, password: password, handler: handler)
    }
    
    func signIn(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
    ) {
        self.appDelegate.sessionStore.signIn(email: email, password: password, handler: handler)
    }
    
    func signOut () -> Bool {
        let didSignOut: Bool = self.appDelegate.sessionStore.signOut()
        if didSignOut {
            self.isAuthenticated = false
        }
        return didSignOut
    }
}
