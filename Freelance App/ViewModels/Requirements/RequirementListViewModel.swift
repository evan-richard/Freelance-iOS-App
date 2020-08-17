//
//  RequirementListViewModel.swift
//  Freelance App
//
//  Created by Evan Richard on 7/8/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import UIKit
import Combine

class RequirementListViewModel: ObservableObject {
    @Published var requirementCellViewModels = [RequirementCellViewModel]()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.appDelegate.projectsStore.$currentProject.sink { currentProject in
            if let topLevelReqs = currentProject?.topLevelReqs {
                self.appDelegate.requirementsStore.$requirements.map { requirements in
                    self.flattenRequirementTitles(requirements: requirements, orderOfIds: topLevelReqs).map { requirementTitle in
                        RequirementCellViewModel(title: requirementTitle)
                    }
                }
                .assign(to: \.requirementCellViewModels, on: self)
                .store(in: &self.cancellables)
            }
        }
        .store(in: &cancellables)
    }
    
    deinit {
        self.cancellables.forEach { cancellable in
            cancellable.cancel()
            self.cancellables.remove(cancellable)
        }
    }
    
    func insertRequirement(isInsertBefore: Bool, title: String) {
        if title != "" {
            if let requirement: Requirement = self.appDelegate.requirementsStore.selectedRequirement {
                self.appDelegate.requirementsStore.insertRequirement(isInsertBefore: isInsertBefore, title: title, referringRequirement: requirement, existingTopLevelReqs: self.appDelegate.projectsStore.currentProject?.topLevelReqs)
            }
        }
    }
    
    func addChildRequirement(title: String) {
        if title != "" {
            if let requirement: Requirement = self.appDelegate.requirementsStore.selectedRequirement {
                self.appDelegate.requirementsStore.addChildRequirement(referringRequirement: requirement, title: title)
            }
        }
    }
    
    func renameRequirement(title: String) {
        if title != "" {
            if let requirement: Requirement = self.appDelegate.requirementsStore.selectedRequirement {
                self.appDelegate.requirementsStore.renameRequirement(requirement: requirement, title: title)
            }
        }
    }
    
    func deleteRequirement() {
        if let requirement: Requirement = self.appDelegate.requirementsStore.selectedRequirement {
            self.appDelegate.requirementsStore.deleteRequirement(requirement: requirement, existingTopLevelReqs: self.appDelegate.projectsStore.currentProject?.topLevelReqs)
        }
    }
    
    func createRequirement(title: String) {
        if title != "" {
            if let projectId: String = self.appDelegate.projectsStore.currentProject?.id {
                self.appDelegate.requirementsStore.createRequirement(title: title, projectId: projectId)
            }
        }
    }
    
    private func flattenRequirementTitles(requirements: [Requirement], orderOfIds: [String], indexPrefix: String = "") -> [String] {
        var flattenedRequirements: [String] = []
        for (index, requirementId) in orderOfIds.enumerated() {
            if let requirement = requirements.first(where: {
                $0.id.trimmingCharacters(in: .whitespaces) == requirementId.trimmingCharacters(in: .whitespaces)
            }) {
                flattenedRequirements.append("\(indexPrefix)\(index + 1). \(requirement.title)")
                if (requirement.childReqIds ?? []).count > 0 {
                    flattenedRequirements.append(contentsOf: self.flattenRequirementTitles(requirements: requirements, orderOfIds: requirement.childReqIds!, indexPrefix: "\(indexPrefix)\(index + 1)."))
                }
            }
        }
        return flattenedRequirements
    }
}
