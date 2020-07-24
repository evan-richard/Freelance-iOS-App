//
//  UserStore.swift
//  Freelance App
//
//  Created by Evan Richard on 7/13/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import Combine

class SessionStore : ObservableObject {
    @Published var session: User?
    
    private let db = Firestore.firestore()
    var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        if CoreConstants.USE_FIRESTORE {
            self.listen()
        } else {
            self.session = User(
                id: "test1",
                email: "test@email.com",
                displayName: "John Doe"
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
                self.session = User(
                    id: user.uid,
                    email: user.email
                )
                self.db.collection("users").document(user.uid).addSnapshotListener { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        if let data = querySnapshot?.data() {
                            self.session?.displayName = data["displayName"] as? String
                            self.session?.type = data["type"] as? String
                        }
                        print("Welcome user: \(String(describing: self.session?.displayName))")
                    }
                }
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
