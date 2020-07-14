//
//  RequirementEditAssignee.swift
//  Freelance App
//
//  Created by Evan Richard on 7/12/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementEditAssignee: View {
    @ObservedObject var projectMemberListVM: ProjectMemberListViewModel = ProjectMemberListViewModel()
    
    @State private var searchString: String = ""
    @State private var isSearching: Bool = false
    
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
                }) {
                    Text("Save")
                        .fontWeight(.semibold)
                }
                .accentColor(.purple)
            }
            SearchBar(searchString: $searchString, isSearching: $isSearching)
            ProjectMemberListView(projectMemberListVM: projectMemberListVM, searchString: $searchString, sectionValueId: $sectionValueId)
        }
        .padding()
    }
}

struct RequirementEditAssignee_Previews: PreviewProvider {
    static var previews: some View {
        RequirementEditAssignee(isEditOpen: Binding.constant(true), sectionValueId: Binding.constant("test1"))
    }
}
