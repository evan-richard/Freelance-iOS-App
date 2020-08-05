//
//  ProjectListCell.swift
//  Freelance App
//
//  Created by Evan Richard on 7/7/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct ProjectListCellView: View {
    @ObservedObject var projectCellVM: ProjectCellViewModel
    @Binding var isPopupViewOpen: Bool
    @Binding var contextMenuAction: String
    @Binding var actionProjectId: String
    @Binding var actionProjectTitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(projectCellVM.appName).fontWeight(.semibold)
            Text(projectCellVM.customerName).font(.subheadline).foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
        .contextMenu {
            Button(action: self.openPopupRenameAction) {
                Text(RequirementMenuActionConstants.RENAME)
                IconConstants.EDIT
            }
            
            Button(action: self.openPopupDeleteAction) {
                Text(RequirementMenuActionConstants.DELETE)
                IconConstants.DELETE
            }
        }
    }
    
    private func openPopupDeleteAction() {
        self.actionProjectId = self.projectCellVM.projectId
        self.actionProjectTitle = self.projectCellVM.appName
        self.contextMenuAction = ProjectMenuActionConstants.DELETE
        withAnimation {
            self.isPopupViewOpen.toggle()
        }
    }
    
    private func openPopupRenameAction() {
        self.actionProjectId = self.projectCellVM.projectId
        self.actionProjectTitle = self.projectCellVM.appName
        self.contextMenuAction = ProjectMenuActionConstants.RENAME
        withAnimation {
            self.isPopupViewOpen.toggle()
        }
    }
}

struct ProjectListCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListCellView(projectCellVM: ProjectCellViewModel(projectId: "123", appName: "Application Name:", customerName: "Customer Name"), isPopupViewOpen: Binding.constant(false), contextMenuAction: Binding.constant(""), actionProjectId: Binding.constant(""), actionProjectTitle: Binding.constant(""))
    }
}
