//
//  UserStore.swift
//  Freelance App
//
//  Created by Evan Richard on 7/13/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import Combine

class SessionStore : ObservableObject {
    @Published var session: User?
    
    var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        if CoreConstants.USE_FIRESTORE {
            self.listen()
        } else {
            self.session = User(
                id: "test1",
                email: "test@email.com"
            )
        }
    }
    
    deinit {
        if CoreConstants.USE_FIRESTORE {
            self.unbind()
        }
    }

    func listen () {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                print("Welcome user: \(String(describing: user.uid))")
                self.session = User(
                    id: user.uid,
                    email: user.email
                )
            } else {
                self.session = nil
            }
        }
    }

    func signUp(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }

    func signIn(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }

    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
        }
    }
    
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
