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
    
//    private let db = Firestore.firestore()
    
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
            Requirement(id: "1", projectId: "123", title: "Landing Page", childReqIds: ["2", "3", "4"]),
            Requirement(id: "2", projectId: "123", title: "Navigation Bar"),
            Requirement(id: "3", projectId: "123", title: "Website Logo"),
            Requirement(id: "4", projectId: "123", title: "Video Thumbclip"),
            Requirement(id: "5", projectId: "123", title: "About Page", childReqIds: ["6"]),
            Requirement(id: "6", projectId: "123", title: "Biography", childReqIds: ["7", "8"]),
            Requirement(id: "7", projectId: "123", title: "Mission Statement"),
            Requirement(id: "8", projectId: "123", title: "Company History"),
            Requirement(id: "9", projectId: "123", title: "Portfolio")
        ]
    }
}
