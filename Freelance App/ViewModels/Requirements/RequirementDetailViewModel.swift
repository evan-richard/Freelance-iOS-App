//
//  RequirementDetailViewModel.swift
//  Freelance App
//
//  Created by Evan Richard on 7/9/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import UIKit
import Combine

class RequirementDetailViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var titleWithPrefix: String = ""
    @Published var status: String = ""
    @Published var assignee: String = ""
    @Published var assigneeId: String = ""
    @Published var features: [String] = []
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        if let selectedRequirement = self.appDelegate.requirementsStore?.selectedRequirement {
            self.title = selectedRequirement.title
            self.titleWithPrefix = self.appDelegate.requirementsStore!.selectedRequirementPrefixedTitle
            self.status = selectedRequirement.status
            self.assignee = selectedRequirement.assignee ?? "None"
            self.assigneeId = selectedRequirement.assigneeId ?? ""
            self.features = selectedRequirement.features ?? []
        }
    }
    
    func updateAssignee(assigneeId: String) {
        if let selectedRequirement = self.appDelegate.requirementsStore?.selectedRequirement {
            if let assignee: User = self.appDelegate.projectMembersStore?.projectMembers.first(where: { member in
                member.id == assigneeId
            }) {
                    self.appDelegate.requirementsStore?.updateRequirementAssignee(requirement: selectedRequirement, assignee: assignee)
                    self.assignee = assignee.displayName ?? "None"
                    self.assigneeId = assignee.id
            } else {
                self.appDelegate.requirementsStore?.removeRequirementAssignee(requirement: selectedRequirement)
                self.assignee = "None"
                self.assigneeId = ""
            }
        }
    }
    
    func updateStatus(status: String) {
        if let selectedRequirement = self.appDelegate.requirementsStore?.selectedRequirement {
            self.appDelegate.requirementsStore?.updateRequirementStatus(requirement: selectedRequirement, status: status)
            self.status = status
        }
    }
    
    func updateFeatures(features: [String]) {
        if let selectedRequirement = self.appDelegate.requirementsStore?.selectedRequirement {
            self.appDelegate.requirementsStore?.updateRequirementFeatures(requirement: selectedRequirement, features: features)
            self.features = features
        }
    }
}
