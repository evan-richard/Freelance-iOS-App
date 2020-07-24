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
    @Published var titleWithPrefix = ""
    @Published var status: String = ""
    @Published var assignee: String = ""
    @Published var assigneeId: String = ""
    @Published var features: [String] = []
    
    private var selectedRequirement: Requirement?
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var cancellables = Set<AnyCancellable>()
    
    init(requirementTitle: String) {
        if let selectedRequirement: Requirement = getRequirementFromTitle(requirementTitle: requirementTitle) {
            self.selectedRequirement = selectedRequirement
            self.title = selectedRequirement.title
            self.titleWithPrefix = requirementTitle
            self.status = selectedRequirement.status
            self.assignee = selectedRequirement.assignee ?? "None"
            self.assigneeId = selectedRequirement.assigneeId ?? ""
            self.features = selectedRequirement.features ?? []
        }
    }
    
    func updateAssignee(assigneeId: String) {
        if self.selectedRequirement != nil {
            if let assignee: User = self.appDelegate.projectMembersStore?.projectMembers.first(where: { member in
                member.id == assigneeId
            }) {
                    self.appDelegate.requirementsStore?.updateRequirementAssignee(requirement: self.selectedRequirement!, assignee: assignee)
                    self.assignee = assignee.displayName ?? "None"
                    self.assigneeId = assignee.id
            } else {
                self.appDelegate.requirementsStore?.removeRequirementAssignee(requirement: self.selectedRequirement!)
                self.assignee = "None"
                self.assigneeId = ""
            }
        }
    }
    
    func updateStatus(status: String) {
        if self.selectedRequirement != nil {
            self.appDelegate.requirementsStore?.updateRequirementStatus(requirement: self.selectedRequirement!, status: status)
            self.status = status
        }
    }
    
    func updateFeatures(features: [String]) {
        if self.selectedRequirement != nil {
            self.appDelegate.requirementsStore?.updateRequirementFeatures(requirement: self.selectedRequirement!, features: features)
            self.features = features
        }
    }
    
    private func getRequirementFromTitle(requirementTitle: String) -> Requirement? {
        var selectedRequirement: Requirement? = nil
        
        // Want to parse the actual title from the pre-pended index
        let splitTitle: [Substring] = requirementTitle.split(separator: ".")
        let parsedTitle: String = String(splitTitle[splitTitle.count - 1]).trimmingCharacters(in: .whitespaces)
        
        if let requirements = self.appDelegate.requirementsStore?.requirements {
            selectedRequirement = requirements.first(where: { $0.title == parsedTitle })
        }
        return selectedRequirement
    }
    
}
