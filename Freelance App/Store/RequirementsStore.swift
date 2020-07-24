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
    @Published var selectedRequirementPrefixedTitle: String = ""
    @Published var selectedRequirement: Requirement? = nil
    
    private let db = Firestore.firestore()
    
    init(projectId: String) {
        self.loadRequirementsList(projectId: projectId)
    }
    
    func updateRequirementAssignee(requirement: Requirement, assignee: User) {
        if CoreConstants.USE_FIRESTORE {
            db.collection("requirements").document(requirement.id).updateData([
                "assignee": assignee.displayName!,
                "assigneeId": assignee.id
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        } else {
            if let i: Int = self.requirements.firstIndex(where: { req in
                req.id == requirement.id
            }) {
                self.requirements[i].assignee = assignee.displayName
                self.requirements[i].assigneeId = assignee.id
            }
        }
    }
    
    func removeRequirementAssignee(requirement: Requirement) {
        if CoreConstants.USE_FIRESTORE {
            db.collection("requirements").document(requirement.id).updateData([
                "assignee": FieldValue.delete(),
                "assigneeId": FieldValue.delete()
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        } else {
            if let i: Int = self.requirements.firstIndex(where: { req in
                req.id == requirement.id
            }) {
                self.requirements[i].assignee = nil
                self.requirements[i].assigneeId = nil
            }
        }
    }
    
    func updateRequirementStatus(requirement: Requirement, status: String) {
        if CoreConstants.USE_FIRESTORE {
            db.collection("requirements").document(requirement.id).updateData([
                "status": status
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        } else {
            if let i: Int = self.requirements.firstIndex(where: { req in
                req.id == requirement.id
            }) {
                self.requirements[i].status = status
            }
        }
    }
    
    func updateRequirementFeatures(requirement: Requirement, features: [String]) {
        if CoreConstants.USE_FIRESTORE {
            db.collection("requirements").document(requirement.id).updateData([
                "features": features
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        } else {
            if let i: Int = self.requirements.firstIndex(where: { req in
                req.id == requirement.id
            }) {
                self.requirements[i].features = features
            }
        }
    }
    
    func renameRequirement(requirement: Requirement, title: String) {
        if CoreConstants.USE_FIRESTORE {
            db.collection("requirements").document(requirement.id).updateData([
                "title": title
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        } else {
            if let i: Int = self.requirements.firstIndex(where: { req in
                req.id == requirement.id
            }) {
                self.requirements[i].title = title
            }
        }
    }
    
    func deleteRequirement(requirement: Requirement) {
        if CoreConstants.USE_FIRESTORE {
            db.collection("requirements").document(requirement.id).delete() { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        } else {
            if let i: Int = self.requirements.firstIndex(where: { req in
                req.id == requirement.id
            }) {
                self.requirements.remove(at: i)
            }
        }
    }
    
    private func loadRequirementsList(projectId: String) -> Void {
        if CoreConstants.USE_FIRESTORE {
            db.collection("requirements").whereField("projectId", isEqualTo: projectId).addSnapshotListener { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.requirements = querySnapshot!.documents.compactMap { document -> Requirement? in
                        try? document.data(as: Requirement.self)
                    }
                }
            }
        } else {
            self.requirements = [
                Requirement(id: "1", projectId: "123", title: "Landing Page", status: "In Progress", assignee: "Developer 1", assigneeId: "test1", childReqIds: ["2", "3", "4"]),
                Requirement(id: "2", projectId: "123", title: "Navigation Bar", status: "To-Do", features: ["Feature 1 description goes here", "And then another feature description follows that one", "We may have a bit of a longer feature description at times, but that should still be OK", "And a short one too"]),
                Requirement(id: "3", projectId: "123", title: "Website Logo", status: "In Progress", assignee: "Developer 2", assigneeId: "test2"),
                Requirement(id: "4", projectId: "123", title: "Video Thumbclip", status: "To-Do"),
                Requirement(id: "5", projectId: "123", title: "About Page", status: "To-Do", childReqIds: ["6"]),
                Requirement(id: "6", projectId: "123", title: "Biography", status: "To-Do", childReqIds: ["7", "8"]),
                Requirement(id: "7", projectId: "123", title: "Mission Statement", status: "To-Do", features: ["Feature 1 description goes here", "And then another feature description follows that one", "We may have a bit of a longer feature description at times, but that should still be OK", "And a short one too"]),
                Requirement(id: "8", projectId: "123", title: "Company History", status: "To-Do"),
                Requirement(id: "9", projectId: "123", title: "Portfolio", status: "To-Do")
            ]
        }
    }
}
