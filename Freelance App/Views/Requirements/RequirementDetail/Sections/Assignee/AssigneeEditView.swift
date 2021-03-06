//
//  RequirementEditAssignee.swift
//  Freelance App
//
//  Created by Evan Richard on 7/12/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct AssigneeEditView: View {
    @ObservedObject private var projectMemberListVM: ProjectMemberListViewModel = ProjectMemberListViewModel()
    @ObservedObject var requirementDetailVM: RequirementDetailViewModel
    @State private var searchString: String = ""
    @State private var isSearching: Bool = false
    @State private var selectedMemberId: String = ""
    @Binding var isEditOpen: Bool
    
    var body: some View {
        VStack {
            EditSectionHeaderView(label: "Assignee", action: self.onSaveAction)
            SearchBarView(searchString: $searchString, isSearching: $isSearching)
            AssigneeListView(projectMemberListVM: projectMemberListVM, searchString: $searchString, selectedMemberId: $selectedMemberId)
        }
        .padding()
        .onAppear {
            self.selectedMemberId = self.requirementDetailVM.assigneeId
        }
    }
    
    private func onSaveAction() {
        self.isEditOpen.toggle()
        self.requirementDetailVM.updateAssignee(assigneeId: self.selectedMemberId)
    }
}

struct AssigneeEditView_Previews: PreviewProvider {
    static var previews: some View {
        AssigneeEditView(requirementDetailVM: RequirementDetailViewModel(), isEditOpen: Binding.constant(true))
    }
}
