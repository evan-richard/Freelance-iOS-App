//
//  ProjectListCellView.swift
//  Freelance App
//
//  Created by Evan Richard on 8/14/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct ProjectListCellView: View {
    @ObservedObject var projectCellVM: ProjectCellViewModel
    @Binding var newProjectId: String
    
    var selectAction: () -> Void
    
    var body: some View {
        Button(action: self.onSelectAction) {
            VStack(alignment: .leading, spacing: 8) {
                Text(projectCellVM.appName)
                Text(projectCellVM.customerName)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 10)
        }
    }
    
    private func onSelectAction() {
        self.newProjectId = projectCellVM.projectId
        self.selectAction()
    }
}

struct ProjectListCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListCellView(
            projectCellVM: ProjectCellViewModel(
                projectId: "123",
                appName: "Navigation App",
                customerName: "Navigator Inc."
            ),
            newProjectId: Binding.constant(""),
            selectAction: {}
        )
    }
}
