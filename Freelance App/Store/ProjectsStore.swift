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
    
    private func loadProjectsList(userId: String) -> Void {
//        db.collection("projects").whereField("grantedUsers", arrayContains: userId).getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                self.projects = querySnapshot!.documents.compactMap { document -> Project? in
//                    try? document.data(as: Project.self)
//                }
//            }
//        }
        self.projects = [
            Project(id: "123", grantedUsers: [userId], appName: "RocketJump Website", customerName: "RocketJump", description: "The folks at RocketJump need a website to showcase some of the creative talent within the company. They would like a progressive web application that supports phone, tablet, and desktop views. They would also like to incorporate some fun HTML5 animations.", topLevelReqs: ["1", "5", "9"]
            ),
            Project(id: "124", grantedUsers: [userId], appName: "Navigator iOS Application", customerName: "Navigator Inc."),
            Project(id: "125", grantedUsers: [userId], appName: "Prosthetic Design", customerName: "Angle Prosthetics")
        ]
    }
}
