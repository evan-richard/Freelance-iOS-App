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
        self.appDelegate.projectsStore!.$projects.map { projects in
            projects.map { project in
                ProjectCellViewModel(projectId: project.id, appName: project.appName, customerName: project.customerName)
            }
        }
        .assign(to: \.projectCellViewModels, on: self)
        .store(in: &cancellables)
        self.numberOfProjects = self.projectCellViewModels.count
    }
    
    func setCurrentProject(projectId: String) {
        self.appDelegate.projectsStore!
            .setCurrentProject(project: self.appDelegate.projectsStore!.projects
                .first(where: { project in
                    project.id == projectId
                })
            )
        self.appDelegate.requirementsStore = RequirementsStore(projectId: projectId)
    }
}
