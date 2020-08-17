//
//  ProjectUsersViewModel.swift
//  Freelance App
//
//  Created by Evan Richard on 7/13/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import UIKit
import Combine

class ProjectMemberListViewModel: ObservableObject {
    @Published var projectMemberCellViewModels: [ProjectMemberCellViewModel] = [ProjectMemberCellViewModel]()
    @Published var assignee: ProjectMemberCellViewModel?
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.appDelegate.projectMembersStore.$projectMembers
            .map { projectMembers in
                projectMembers.map { projectMember in
                    ProjectMemberCellViewModel(
                        projectMemberId: projectMember.id,
                        displayName: projectMember.displayName ?? ""
                    )
            }
        }
        .assign(to: \.projectMemberCellViewModels, on: self)
        .store(in: &cancellables)
        self.projectMemberCellViewModels.insert(ProjectMemberCellViewModel(projectMemberId: "", displayName: "Unassigned"), at: 0)
    }
}
