//
//  RequirementCellViewModel.swift
//  Freelance App
//
//  Created by Evan Richard on 7/8/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import UIKit

class RequirementCellViewModel: ObservableObject, Identifiable  {
    var id: UUID
    @Published var title: String = ""
    @Published var font: Font = Font.system(size: 30)
    @Published var paddingLeft: CGFloat = 0
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var cancellables = Set<AnyCancellable>()
    
    init(title: String) {
        id = UUID()
        self.title = title
        
        switch self.title.split(separator: ".").count {
            case 2:
                self.font = Font.system(size: 20)
                self.paddingLeft = 0
                break
            case 3:
                self.font = Font.system(size: 18)
                self.paddingLeft = 25
                break
            case 4:
                self.font = Font.system(size: 16)
                self.paddingLeft = 50
                break
            default:
                self.font = Font.system(size: 26)
                self.paddingLeft = 0
        }
    }
    
    func setSeletectedRequirement() {
        self.appDelegate.requirementsStore?.selectedRequirementPrefixedTitle = self.title
        self.appDelegate.requirementsStore?.selectedRequirement = self.getRequirementFromTitle()
    }
    
    func insertRequirement(isInsertBefore: Bool) {}
    
    func addChildRequirement() {}
    
    func renameRequirement(title: String) {
        if let requirement: Requirement = self.getRequirementFromTitle() {
            self.appDelegate.requirementsStore?.renameRequirement(requirement: requirement, title: title)
            let splitTitle: [Substring] = self.title.split(separator: ".")
            self.title = "\(splitTitle[0 ..< splitTitle.count - 1].joined()) \(title)"
        }
    }
    
    func deleteRequirement() {
        if let requirement: Requirement = self.getRequirementFromTitle() {
            self.appDelegate.requirementsStore?.deleteRequirement(requirement: requirement)
        }
    }
    
    private func getRequirementFromTitle() -> Requirement? {
        // Want to parse the actual title from the pre-pended index
        let splitTitle: [Substring] = self.title.split(separator: ".")
        let parsedTitle: String = String(splitTitle[splitTitle.count - 1]).trimmingCharacters(in: .whitespaces)
        
        return self.appDelegate.requirementsStore?.requirements
            .first { requirement in
                requirement.title == parsedTitle
            }
    }
}
