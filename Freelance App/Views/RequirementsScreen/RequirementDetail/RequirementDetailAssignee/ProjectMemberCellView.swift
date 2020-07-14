//
//  ProjectMemberCellView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/13/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct ProjectMemberCellView: View {
    @ObservedObject var projectMemberCellVM: ProjectMemberCellViewModel
    
    @Binding var sectionValueId: String
    
    var body: some View {
        Button(action: {
            self.sectionValueId = self.projectMemberCellVM.projectMemberId
        }) {
            HStack {
                Text(projectMemberCellVM.displayName)
                Spacer()
                if sectionValueId == projectMemberCellVM.projectMemberId {
                    Image(systemName: "checkmark")
                        .foregroundColor(.purple)
                }
            }
        }
    }
}

struct ProjectMemberCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectMemberCellView(projectMemberCellVM: ProjectMemberCellViewModel(projectMemberId: "test1", displayName: "Evan Richard"), sectionValueId: Binding.constant("test1"))
    }
}
