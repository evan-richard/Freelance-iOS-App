//
//  ProjectMemberCell.swift
//  Freelance App
//
//  Created by Evan Richard on 7/13/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import Combine

class ProjectMemberCellViewModel: ObservableObject, Identifiable  {
    var id: UUID
    @Published var projectMemberId: String = ""
    @Published var displayName: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(projectMemberId: String, displayName: String) {
        id = UUID()
        self.projectMemberId = projectMemberId
        self.displayName = displayName
    }
    
}
