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
    @Published var currentProjectName: String = "App Name"
    @Published var currentProjectCustomer: String = "Customer's Name Inc."
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.appDelegate.projectsStore.$currentProject.sink { currentProject in
            if let project = currentProject {
                self.currentProjectName = project.appName
                self.currentProjectCustomer = project.customerName
                self.appDelegate.requirementsStore.loadRequirementsList(projectId: project.id)
                self.appDelegate.discussionsStore.loadDiscussionsList(projectId: project.id)
                self.appDelegate.projectMembersStore.loadProjectMembersList(grantedUsers: project.grantedUsers)
            }
        }
        .store(in: &cancellables)
        
        self.setCurrentProject()
        
        self.appDelegate.projectsStore.$projects.map { projects in
            projects.map { project in
                ProjectCellViewModel(
                    projectId: project.id,
                    appName: project.appName,
                    customerName: project.customerName
                )
            }
        }
        .assign(to: \.projectCellViewModels, on: self)
        .store(in: &self.cancellables)
    }
    
    func setCurrentProject(newProjectId: String = "") {
        if newProjectId != "" {
            self.appDelegate.sessionStore.setLastProjectId(projectId: newProjectId)
            
            if let currentProject: Project = self.appDelegate.projectsStore.projects.first(where: { project in
                project.id == newProjectId
            }) {
                self.appDelegate.projectsStore.setCurrentProject(project: currentProject)
            }
        } else {
            if let currentProjectId: String = self.appDelegate.sessionStore.session?.lastProjectId {
                if let currentProject: Project = self.appDelegate.projectsStore.projects.first(where: { project in
                    project.id == currentProjectId
                }) {
                    self.appDelegate.projectsStore.setCurrentProject(project: currentProject)
                }
            }
        }
    }
    
    func createProject(name: String, customer: String) {
        if (name != "" && customer != "") {
            if let currentUserId: String = self.appDelegate.sessionStore.session?.id {
                self.appDelegate.projectsStore.createProject(
                    currentUserId: currentUserId,
                    name: name,
                    customer: customer
                )
            }
        }
    }
    
    func renameProject(projectId: String, name: String) {
        if (name != "") {
            self.appDelegate.projectsStore.renameProject(
                projectId: projectId,
                name: name
            )
        }
    }
    
    func deleteProject(projectId: String) {
        self.appDelegate.projectsStore.deleteProject(
            projectId: projectId
        )
    }
}
