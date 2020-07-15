//
//  ProjectMemberListView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/13/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct ProjectMemberListView: View {
    @ObservedObject var projectMemberListVM: ProjectMemberListViewModel
    @Binding var searchString: String
    @Binding var selectedMemberId: String
    
    var body: some View {
        VStack {
            List(projectMemberListVM.projectMemberCellViewModels.filter({ projectMemberCellVM in
                if searchString != "" {
                    return projectMemberCellVM.displayName.lowercased().contains(searchString.lowercased())
                } else {
                    return true
                }
            })) { projectMemberCellVM in
                ProjectMemberCellView(projectMemberCellVM: projectMemberCellVM, selectedMemberId: self.$selectedMemberId)
            }
            Spacer()
        }
    }
}

struct ProjectMemberListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectMemberListView(projectMemberListVM: ProjectMemberListViewModel(), searchString: Binding.constant(""), selectedMemberId: Binding.constant("test1"))
    }
}
