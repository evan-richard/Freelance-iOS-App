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
        self.appDelegate.requirementsStore.selectedRequirementPrefixedTitle = self.title
        self.appDelegate.requirementsStore.selectedRequirement = self.getRequirementFromTitle()
        self.appDelegate.discussionsStore.selectedDiscussion = self.appDelegate.discussionsStore.discussions.first { discussion in
            discussion.requirementId == self.appDelegate.requirementsStore.selectedRequirement?.id ?? ""
        }
        if self.appDelegate.discussionsStore.selectedDiscussion != nil {
            self.appDelegate.discussionsStore.populateMessagesForDiscussion()
        }
    }
    
    func getParsedTitle() -> String {
        // Want to parse the actual title from the pre-pended index
        let splitTitle: [Substring] = self.title.split(separator: ".")
        return String(splitTitle[splitTitle.count - 1]).trimmingCharacters(in: .whitespaces)
    }
    
    private func getRequirementFromTitle() -> Requirement? {
        let parsedTitle: String = self.getParsedTitle()
        
        return self.appDelegate.requirementsStore.requirements
            .first { requirement in
                requirement.title == parsedTitle
            }
    }
}
