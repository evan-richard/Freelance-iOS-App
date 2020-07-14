//
//  RequirementsStore.swift
//  Freelance App
//
//  Created by Evan Richard on 7/7/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class RequirementsStore: ObservableObject {
    @Published var requirements: [Requirement] = [Requirement]()
    
    private let db = Firestore.firestore()
    
    init(projectId: String) {
        self.loadRequirementsList(projectId: projectId)
    }
    
    private func loadRequirementsList(projectId: String) -> Void {
//        db.collection("requirements").whereField("projectId", isEqualTo: projectId).getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                self.requirements = querySnapshot!.documents.compactMap { document -> Requirement? in
//                    try? document.data(as: Requirement.self)
//                }
//            }
//        }
        self.requirements = [
            Requirement(id: "1", projectId: "123", title: "Landing Page", status: "In Progress", assignee: "Developer 1", assigneeId: "test1", childReqIds: ["2", "3", "4"]),
            Requirement(id: "2", projectId: "123", title: "Navigation Bar", status: "To-Do"),
            Requirement(id: "3", projectId: "123", title: "Website Logo", status: "In Progress", assignee: "Developer 2", assigneeId: "test2"),
            Requirement(id: "4", projectId: "123", title: "Video Thumbclip", status: "To-Do"),
            Requirement(id: "5", projectId: "123", title: "About Page", status: "To-Do", childReqIds: ["6"]),
            Requirement(id: "6", projectId: "123", title: "Biography", status: "To-Do", childReqIds: ["7", "8"]),
            Requirement(id: "7", projectId: "123", title: "Mission Statement", status: "To-Do"),
            Requirement(id: "8", projectId: "123", title: "Company History", status: "To-Do"),
            Requirement(id: "9", projectId: "123", title: "Portfolio", status: "To-Do")
        ]
    }
}
