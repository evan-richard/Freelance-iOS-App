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
        let asyncGroup: DispatchGroup = DispatchGroup()
        asyncGroup.enter()

        DispatchQueue.main.async {
            self.appDelegate.sessionStore = SessionStore(dispatchGroup: asyncGroup)
            self.initializeUserFromStore()
        }

        asyncGroup.notify(queue: .main) {
            self.appDelegate.projectsStore = ProjectsStore(userId: self.appDelegate.sessionStore?.session?.id ?? "")
            self.appDelegate.requirementsStore = RequirementsStore(projectId: self.appDelegate.sessionStore!.session?.lastProjectId ?? "")
            self.appDelegate.discussionsStore = DiscussionsStore(projectId: self.appDelegate.sessionStore!.session?.lastProjectId ?? "")
            self.appDelegate.sessionInitGroup.leave()
        }
    }
    
    func signUp(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
    ) {
        self.appDelegate.sessionStore?.signUp(email: email, password: password, handler: handler)
    }
    
    func signIn(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
    ) {
        self.appDelegate.sessionStore?.signIn(email: email, password: password, handler: handler)
    }
    
    func signOut () -> Bool {
        let didSignOut: Bool = self.appDelegate.sessionStore?.signOut() ?? false
        if didSignOut {
            self.isAuthenticated = false
        }
        return didSignOut
    }
    
    private func initializeUserFromStore() {
        self.appDelegate.sessionStore?.$session.sink(receiveValue: { (user) in
            self.id = user?.id ?? ""
            self.displayName = user?.displayName
            self.isAuthenticated = true
        })
        .store(in: &cancellables)
    }
}
