//
//  RequirementListRowItem.swift
//  Freelance App
//
//  Created by Evan Richard on 7/4/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementsListCellView: View {
    @ObservedObject var requirementCellVM: RequirementCellViewModel
    @Binding var isRequirementDetailOpen: Bool
    @Binding var isPopupViewOpen: Bool
    @Binding var contextMenuAction: String
    @Binding var requirementTitle: String
    
    var body: some View {
        Button(action: self.openRequirementDetailAction) {
            Text(requirementCellVM.title)
                .padding(.leading, requirementCellVM.paddingLeft)
                .padding(.vertical, 8)
                .font(requirementCellVM.font)
        }
        .contextMenu {
            Button(action: {
                self.openPopupTextFieldAction(action: RequirementMenuActionConstants.INSERT_BEFORE)
            }) {
                Text(RequirementMenuActionConstants.INSERT_BEFORE)
                IconConstants.INSERT_BEFORE
            }

            Button(action: {
                self.openPopupTextFieldAction(action: RequirementMenuActionConstants.INSERT_AFTER)
            }) {
                Text(RequirementMenuActionConstants.INSERT_AFTER)
                IconConstants.INSERT_AFTER
            }
            
            Button(action: {
                self.openPopupTextFieldAction(action: RequirementMenuActionConstants.ADD_CHILD)
            }) {
                Text(RequirementMenuActionConstants.ADD_CHILD)
                IconConstants.ADD_CHILD
            }
            .disabled(requirementCellVM.title.split(separator: ".").count == 4)
            
            Button(action: {
                self.openPopupTextFieldAction(action: RequirementMenuActionConstants.RENAME)
            }) {
                Text(RequirementMenuActionConstants.RENAME)
                IconConstants.EDIT
            }
            
            Button(action: self.onDeleteAction) {
                Text(RequirementMenuActionConstants.DELETE)
                IconConstants.DELETE
            }
        }
    }
    
    private func openRequirementDetailAction() {
        self.requirementCellVM.setSeletectedRequirement()
        self.isRequirementDetailOpen.toggle()
    }
    
    private func openPopupTextFieldAction(action: String) {
        self.requirementCellVM.setSeletectedRequirement()
        self.contextMenuAction = action
        if action == RequirementMenuActionConstants.RENAME {
            self.requirementTitle = self.requirementCellVM.getParsedTitle()
        } else {
            self.requirementTitle = ""
        }
        withAnimation {
            self.isPopupViewOpen.toggle()
        }
    }
    
    private func onDeleteAction() {
        self.requirementCellVM.setSeletectedRequirement()
        self.contextMenuAction = RequirementMenuActionConstants.DELETE
        withAnimation {
            self.isPopupViewOpen.toggle()
        }
    }
}

struct RequirementsListCellView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementsListCellView(requirementCellVM: RequirementCellViewModel(title: "2. About Page"), isRequirementDetailOpen: Binding.constant(false), isPopupViewOpen: Binding.constant(false), contextMenuAction: Binding.constant(""), requirementTitle: Binding.constant("")
        )
    }
}
