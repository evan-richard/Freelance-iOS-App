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
    private var requirementsSnapshotListener: ListenerRegistration? = nil
    
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
    
    func insertRequirement(isInsertBefore: Bool, title: String, referringRequirement: Requirement, existingTopLevelReqs: [String]?) {
        if CoreConstants.USE_FIRESTORE {
            let ref: DocumentReference = db.collection("requirements").document()
            var requirementData = [
                "id": ref.documentID,
                "projectId": referringRequirement.projectId,
                "title": title,
                "status": RequirementStatusConstants.TO_DO
            ]
            if referringRequirement.parentReqId != nil {
                // Not a top-level requirement, need to update the parent req also
                requirementData["parentReqId"] = referringRequirement.parentReqId
            }
            ref.setData(requirementData) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    if let parentReqId: String = requirementData["parentReqId"] {
                        // Get the existing childReqId array from the parent requirement
                        var childReqIds: [String] = self.requirements.first { requirement in
                            requirement.id == parentReqId
                        }?.childReqIds ?? []
                        
                        // Insert the new requirement in the appropriate place
                        let insertIdx: Int = childReqIds.firstIndex(of: referringRequirement.id) ?? 0
                        childReqIds.insert(ref.documentID, at: isInsertBefore ? insertIdx : insertIdx + 1)
                        
                        self.db.collection("requirements").document(parentReqId).updateData([
                            "childReqIds": childReqIds
                        ]) { err in
                            if let err = err {
                                print("Error updating document: \(err)")
                            }
                        }
                    } else {
                        // Top-level requirement, so update the project
                        var topLevelReqs: [String] = existingTopLevelReqs ?? []
                        
                        // Insert the new requirement in the appropriate place
                        let insertIdx: Int = topLevelReqs.firstIndex(of: referringRequirement.id) ?? 0
                        topLevelReqs.insert(ref.documentID, at: isInsertBefore ? insertIdx : insertIdx + 1)
                        
                        self.db.collection("projects").document(referringRequirement.projectId).updateData([
                            "topLevelReqs": topLevelReqs
                        ]) { err in
                            if let err = err {
                                print("Error updating document: \(err)")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func addChildRequirement(referringRequirement: Requirement, title: String) {
        if CoreConstants.USE_FIRESTORE {
            let ref: DocumentReference = db.collection("requirements").document()
            let requirementData: [String: String] = [
                "id": ref.documentID,
                "projectId": referringRequirement.projectId,
                "title": title,
                "status": RequirementStatusConstants.TO_DO,
                "parentReqId": referringRequirement.id
            ]
            ref.setData(requirementData) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    var childReqIds: [String] = referringRequirement.childReqIds ?? []
                    childReqIds.append(ref.documentID)
                    self.db.collection("requirements").document(referringRequirement.id)
                        .updateData([
                            "childReqIds": childReqIds
                        ]) { updateErr in
                            if let updateErr = updateErr {
                                print("Error updating parent document: \(updateErr)")
                            } else {
                                print("Updated parent document successfully.")
                            }
                        }
                }
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
    
    func deleteRequirement(requirement: Requirement, existingTopLevelReqs: [String]?) {
        if CoreConstants.USE_FIRESTORE {
            let batch: WriteBatch = db.batch()
            
            // Delete the parent and all child documents
            self.deleteRequirementHelper(batch: batch, requirement: requirement)
            
            batch.commit() { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    if let parentReqId: String = requirement.parentReqId {
                        // Get the existing childReqId array from the parent requirement
                        var childReqIds: [String] = self.requirements.first { requirement in
                            requirement.id == parentReqId
                        }?.childReqIds ?? []
                        
                        // Remove the requirement reference
                        let removeIdx: Int = childReqIds.firstIndex(of: requirement.id) ?? 0
                        childReqIds.remove(at: removeIdx)
                        
                        self.db.collection("requirements").document(parentReqId).updateData([
                            "childReqIds": childReqIds
                        ]) { err in
                            if let err = err {
                                print("Error updating document: \(err)")
                            }
                        }
                    } else {
                        // Top-level requirement, so update the project
                        var topLevelReqs: [String] = existingTopLevelReqs ?? []
                        
                        // Insert the new requirement in the appropriate place
                        let removeIdx: Int = topLevelReqs.firstIndex(of: requirement.id) ?? 0
                        topLevelReqs.remove(at: removeIdx)
                        
                        self.db.collection("projects").document(requirement.projectId).updateData([
                            "topLevelReqs": topLevelReqs
                        ]) { err in
                            if let err = err {
                                print("Error updating document: \(err)")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func createRequirement(title: String, projectId: String) {
        if CoreConstants.USE_FIRESTORE {
            let ref: DocumentReference = db.collection("requirements").document()
            let requirementData: [String: String] = [
                "id": ref.documentID,
                "projectId": projectId,
                "title": title,
                "status": RequirementStatusConstants.TO_DO
            ]
            ref.setData(requirementData) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    // Top-level requirement, so update the project
                    let topLevelReqs: [String] = [ref.documentID]
                    
                    self.db.collection("projects").document(projectId).updateData([
                        "topLevelReqs": topLevelReqs
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        }
                    }
                }
            }
        }
    }
    
    private func deleteRequirementHelper(batch: WriteBatch, requirement: Requirement) {
        batch.deleteDocument(db.collection("requirements").document(requirement.id))
        
        requirement.childReqIds?.forEach { id in
            if let childRequirement = self.requirements.first(where: { childRequirement in
                childRequirement.id == id
            }) {
                self.deleteRequirementHelper(batch: batch, requirement: childRequirement)
            }
        }
    }
    
    func loadRequirementsList(projectId: String) -> Void {
        if self.requirementsSnapshotListener != nil {
            self.requirementsSnapshotListener?.remove()
        }
        
        if CoreConstants.USE_FIRESTORE {
            self.requirementsSnapshotListener = db.collection("requirements").whereField("projectId", isEqualTo: projectId).addSnapshotListener { (querySnapshot, err) in
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
                Requirement(id: "2", projectId: "123", title: "Navigation Bar", status: "To-Do", features: ["Feature 1 description goes here", "And then another feature description follows that one", "We may have a bit of a longer feature description at times, but that should still be OK", "And a short one too"], parentReqId: "1"),
                Requirement(id: "3", projectId: "123", title: "Website Logo", status: "In Progress", assignee: "Developer 2", assigneeId: "test2", parentReqId: "1"),
                Requirement(id: "4", projectId: "123", title: "Video Thumbclip", status: "To-Do", parentReqId: "1"),
                Requirement(id: "5", projectId: "123", title: "About Page", status: "To-Do", childReqIds: ["6"]),
                Requirement(id: "6", projectId: "123", title: "Biography", status: "To-Do", childReqIds: ["7", "8"], parentReqId: "5"),
                Requirement(id: "7", projectId: "123", title: "Mission Statement", status: "To-Do", features: ["Feature 1 description goes here", "And then another feature description follows that one", "We may have a bit of a longer feature description at times, but that should still be OK", "And a short one too"], parentReqId: "6"),
                Requirement(id: "8", projectId: "123", title: "Company History", status: "To-Do", parentReqId: "6"),
                Requirement(id: "9", projectId: "123", title: "Portfolio", status: "To-Do")
            ]
        }
    }
}
