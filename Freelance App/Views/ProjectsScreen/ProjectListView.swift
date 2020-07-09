//
//  ProjectListView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/7/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct ProjectListView: View {
    @ObservedObject var projectListVM: ProjectListViewModel
    
    @State private var selectedProjectId: String?
    
    var body: some View {
        List(projectListVM.projectCellViewModels) { projectCellVM in
            NavigationLink(destination: OverviewScreen(), tag: projectCellVM.projectId,
            selection: self.selectedProjectBinding()) {
                ProjectListCell(projectCellVM: projectCellVM)
            }
        }
    }
    
    private func selectedProjectBinding() -> Binding<String?> {
        let binding = Binding<String?>(get: {
            self.selectedProjectId
        }, set: {
            if $0 != nil {
                self.projectListVM.setCurrentProject(projectId: $0!)
            }
            self.selectedProjectId = $0
        })
        return binding
    }
}

struct ProjectListView_Previews: PreviewProvider {
    static var previews: some View {
        let projectListVM: ProjectListViewModel = ProjectListViewModel()
        return ProjectListView(projectListVM: projectListVM)
    }
}
