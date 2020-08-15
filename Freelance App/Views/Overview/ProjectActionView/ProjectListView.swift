//
//  ProjectListView.swift
//  Freelance App
//
//  Created by Evan Richard on 8/14/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct ProjectListView: View {
    @ObservedObject var projectListVM: ProjectListViewModel
    @State private var newProjectId: String = ""
    @Binding var isProjectActionOpen: Bool
    
    var body: some View {
        List(projectListVM.projectCellViewModels) { projectCellVM in
            ProjectListCellView(
                projectCellVM: projectCellVM,
                newProjectId: self.$newProjectId,
                selectAction: self.setCurrentProjectAction
            )
        }
        .listRowBackground(Color(.secondarySystemBackground))
        .frame(width: 250, height: self.isProjectActionOpen ? 230 : 0)
        .cornerRadius(20)
        .animation(Animation.linear(duration: 0.2).delay(self.isProjectActionOpen ? 0.3 : 0))
    }
    
    private func setCurrentProjectAction() {
        self.projectListVM.setCurrentProject(newProjectId: newProjectId)
        self.isProjectActionOpen.toggle()
    }
}

struct ProjectListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListView(projectListVM: ProjectListViewModel(), isProjectActionOpen: Binding.constant(true))
    }
}
