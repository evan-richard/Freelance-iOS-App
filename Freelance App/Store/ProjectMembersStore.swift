//
//  ProjectMembersStore.swift
//  Freelance App
//
//  Created by Evan Richard on 7/13/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ProjectMembersStore: ObservableObject {
    @Published var projectMembers: [User] = [User]()
    
    private let db = Firestore.firestore()
    
    init(grantedUsers: [String]) {
        self.loadProjectMembersList(grantedUsers: grantedUsers)
    }
    
    private func loadProjectMembersList(grantedUsers: [String]) -> Void {
        db.collection("users").whereField("id", in: grantedUsers).addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.projectMembers = querySnapshot!.documents.compactMap { document -> User? in
                    try? document.data(as: User.self)
                }
                .sorted(by: { (user1, user2) in
                    user1.displayName!.compare(user2.displayName!).rawValue < 0
                })
            }
        }
        
//        self.projectMembers = [
//            User(id: "test1", displayName: "Developer 1", type: "developer"),
//            User(id: "test2", displayName: "Developer 2", type: "developer"),
//            User(id: "test3", displayName: "Developer 3", type: "developer"),
//            User(id: "test4", displayName: "Client 1", type: "client"),
//            User(id: "test5", displayName: "Client 2", type: "client"),
//            User(id: "test6", displayName: "Client 3", type: "client")
//        ]
    }
}
