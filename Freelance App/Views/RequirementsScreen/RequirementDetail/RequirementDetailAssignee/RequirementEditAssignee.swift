//
//  RequirementEditAssignee.swift
//  Freelance App
//
//  Created by Evan Richard on 7/12/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementEditAssignee: View {
    @ObservedObject private var projectMemberListVM: ProjectMemberListViewModel = ProjectMemberListViewModel()
    @ObservedObject var requirementDetailVM: RequirementDetailViewModel
    @State private var searchString: String = ""
    @State private var isSearching: Bool = false
    @State private var selectedMemberId: String = ""
    @Binding var isEditOpen: Bool
    @Binding var sectionValueId: String
    
    var body: some View {
        VStack {
            HStack {
                Text("Assignee")
                    .font(.title)
                Spacer()
                Button(action: {
                    self.isEditOpen.toggle()
                    self.requirementDetailVM.updateAssignee(assigneeId: self.selectedMemberId)
                }) {
                    Text("Save")
                        .fontWeight(.semibold)
                }
                .accentColor(.purple)
            }
            SearchBar(searchString: $searchString, isSearching: $isSearching)
            ProjectMemberListView(projectMemberListVM: projectMemberListVM, searchString: $searchString, selectedMemberId: $selectedMemberId)
        }
        .padding()
        .onAppear {
            self.selectedMemberId = self.sectionValueId
        }
        
    }
    
}

struct RequirementEditAssignee_Previews: PreviewProvider {
    static var previews: some View {
        RequirementEditAssignee(requirementDetailVM: RequirementDetailViewModel(requirementTitle: "2. About Page"), isEditOpen: Binding.constant(true), sectionValueId: Binding.constant("test1"))
    }
}
