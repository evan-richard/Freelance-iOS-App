//
//  ProjectListViewModel.swift
//  Freelance App
//
//  Created by Evan Richard on 7/7/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import UIKit
import Combine

class ProjectListViewModel: ObservableObject {
    @Published var projectCellViewModels = [ProjectCellViewModel]()
    @Published var numberOfProjects: Int = 0
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        let userId: String = self.appDelegate.sessionStore?.session?.id ?? ""
        self.appDelegate.projectsStore = ProjectsStore(userId: userId)
        
        self.appDelegate.projectsStore!.$projects.map { projects in
            self.numberOfProjects = projects.count
            return projects.map { project in
                ProjectCellViewModel(projectId: project.id, appName: project.appName, customerName: project.customerName)
            }
        }
        .assign(to: \.projectCellViewModels, on: self)
        .store(in: &cancellables)
    }
    
    func setCurrentProject(projectId: String) {
        if let currentProject: Project = self.appDelegate.projectsStore?.projects.first(where: { project in
            project.id == projectId
        }) {
            self.appDelegate.projectsStore?.setCurrentProject(project: currentProject)
            self.appDelegate.requirementsStore = RequirementsStore(projectId: projectId)
            self.appDelegate.projectMembersStore = ProjectMembersStore(grantedUsers: currentProject.grantedUsers)
            self.appDelegate.discussionsStore = DiscussionsStore(projectId: projectId)
        }
    }
    
    func createProject(name: String, customer: String) {
        if (name != "" && customer != "") {
            if let currentUserId: String = self.appDelegate.sessionStore?.session?.id {
                self.appDelegate.projectsStore?.createProject(
                    currentUserId: currentUserId,
                    name: name,
                    customer: customer
                )
            }
        }
    }
    
    func renameProject(projectId: String, name: String) {
        if (name != "") {
            self.appDelegate.projectsStore?.renameProject(
                projectId: projectId,
                name: name
            )
        }
    }
    
    func deleteProject(projectId: String) {
        self.appDelegate.projectsStore?.deleteProject(
            projectId: projectId
        )
    }
}
