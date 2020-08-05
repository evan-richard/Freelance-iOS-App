//
//  ProjectsStore.swift
//  Freelance App
//
//  Created by Evan Richard on 7/3/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ProjectsStore: ObservableObject {
    @Published var projects: [Project] = [Project]()
    @Published var currentProject: Project? = nil
    
    private let db = Firestore.firestore()
    
    init(userId: String) {
        self.loadProjectsList(userId: userId)
    }
    
    func setCurrentProject(project: Project?) {
        self.currentProject = project
    }
    
    func createProject(currentUserId: String, name: String, customer: String) {
        if CoreConstants.USE_FIRESTORE {
            let ref: DocumentReference = db.collection("projects").document()
            let projectData: [String: Any] = [
                "id": ref.documentID,
                "grantedUsers": [currentUserId],
                "appName": name,
                "customerName": customer
            ]
            ref.setData(projectData) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Successfully added document: \(name)")
                }
            }
        }
    }
    
    func renameProject(projectId: String, name: String) {
        if CoreConstants.USE_FIRESTORE {
            db.collection("projects").document(projectId).updateData([
                "appName": name
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        }
    }
    
    func deleteProject(projectId: String) {
        if CoreConstants.USE_FIRESTORE {
            db.collection("projects").document(projectId).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    // Delete all nodes referencing this project in the db
                    self.deleteHelper(projectId: projectId)
                    print("Document successfully removed!")
                }
            }
        }
    }
    
    private func deleteHelper(projectId: String) {
        if CoreConstants.USE_FIRESTORE {
            let batch: WriteBatch = db.batch()
            // This ensures all of our asynchronous get calls finish
            let batchGroup = DispatchGroup()

            batchGroup.enter()
            DispatchQueue.main.async {
                self.db.collection("requirements")
                    .whereField("projectId", isEqualTo: projectId)
                    .getDocuments { documents, err in
                        documents?.documents.forEach { document in
                            batch.deleteDocument(self.db.collection("requirements").document(document.data()["id"] as! String))
                        }
                        batchGroup.leave()
                    }
            }
        
            batchGroup.enter()
            DispatchQueue.main.async {
                self.db.collection("discussions")
                    .whereField("projectId", isEqualTo: projectId)
                    .getDocuments { documents, err in
                        documents?.documents.forEach { document in
                            batch.deleteDocument(self.db.collection("discussions").document(document.data()["id"] as! String))
                        }
                        batchGroup.leave()
                    }
            }
            
            batchGroup.notify(queue: .main) {
                batch.commit() { err in
                    if let err = err {
                        print("Error deleting references: \(err)")
                    } else {
                        print("References successfully removed!")
                    }
                }
            }
        }
    }
    
    private func loadProjectsList(userId: String) -> Void {
        if CoreConstants.USE_FIRESTORE {
            db.collection("projects").whereField("grantedUsers", arrayContains: userId).addSnapshotListener { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.projects = querySnapshot!.documents.compactMap { document -> Project? in
                        let project: Project? = try? document.data(as: Project.self)
                        if let currentProjectId: String = self.currentProject?.id {
                            if project?.id == currentProjectId {
                                self.currentProject = project
                            }
                        }
                        return project
                    }
                }
            }
        } else {
            self.projects = [
                Project(id: "123", grantedUsers: [userId], appName: "RocketJump Website", customerName: "RocketJump", description: "The folks at RocketJump need a website to showcase some of the creative talent within the company. They would like a progressive web application that supports phone, tablet, and desktop views. They would also like to incorporate some fun HTML5 animations.", topLevelReqs: ["1", "5", "9"]
                ),
                Project(id: "124", grantedUsers: [userId], appName: "Navigator iOS Application", customerName: "Navigator Inc."),
                Project(id: "125", grantedUsers: [userId], appName: "Prosthetic Design", customerName: "Angle Prosthetics")
            ]
        }
    }
}
