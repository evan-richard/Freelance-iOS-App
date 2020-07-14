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
        if let topLevelReqs = self.appDelegate.projectsStore?.currentProject?.topLevelReqs {
            self.appDelegate.requirementsStore?.$requirements.map { requirements in
                self.flattenRequirementTitles(requirements: requirements, orderOfIds: topLevelReqs).map { requirementTitle in
                    RequirementCellViewModel(title: requirementTitle)
                }
            }
            .assign(to: \.requirementCellViewModels, on: self)
            .store(in: &cancellables)
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
