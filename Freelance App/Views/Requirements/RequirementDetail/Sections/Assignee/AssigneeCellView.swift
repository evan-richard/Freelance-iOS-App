//
//  ProjectMemberCellView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/13/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct AssigneeCellView: View {
    @ObservedObject var projectMemberCellVM: ProjectMemberCellViewModel
    @Binding var selectedMemberId: String
    
    var body: some View {
        Button(action: self.selectAssigneeAction) {
            HStack {
                Text(projectMemberCellVM.displayName)
                Spacer()
                if selectedMemberId == projectMemberCellVM.projectMemberId {
                    Image(systemName: "checkmark")
                        .foregroundColor(.purple)
                }
            }
        }
    }
    
    private func selectAssigneeAction() {
        self.selectedMemberId = self.projectMemberCellVM.projectMemberId
    }
}

struct AssigneeCellView_Previews: PreviewProvider {
    static var previews: some View {
        AssigneeCellView(projectMemberCellVM: ProjectMemberCellViewModel(projectMemberId: "test1", displayName: "Evan Richard"), selectedMemberId: Binding.constant("test1"))
    }
}
