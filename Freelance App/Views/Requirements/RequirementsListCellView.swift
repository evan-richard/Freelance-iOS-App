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
    
    var body: some View {
        Button(action: self.openRequirementDetailAction) {
            Text(requirementCellVM.title)
                .padding(.leading, requirementCellVM.paddingLeft)
                .padding(.vertical, 8)
                .font(requirementCellVM.font)
        }
        .contextMenu {
            Button(action: { self.onInsertAction(isInsertBefore: true) }) {
                Text("Insert Before")
                Image(systemName: "arrow.turn.up.right")
            }

            Button(action: { self.onInsertAction(isInsertBefore: false) }) {
                Text("Insert After")
                Image(systemName: "arrow.turn.up.left")
                    .rotationEffect(.degrees(180))
            }
            
            Button(action: self.onAddChildAction) {
                Text("Add Child")
                Image(systemName: "arrow.up.right")
                    .rotationEffect(.degrees(90))
            }
            .disabled(requirementCellVM.title.split(separator: ".").count == 4)
            
            Button(action: self.onRenameAction) {
                Text("Rename")
                Image(systemName: "pencil.and.ellipsis.rectangle")
            }
            
            Button(action: self.onDeleteAction) {
                Text("Delete")
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
    }
    
    private func openRequirementDetailAction() {
        self.requirementCellVM.setSeletectedRequirement()
        self.isRequirementDetailOpen.toggle()
    }
    
    private func onInsertAction(isInsertBefore: Bool) {
        self.requirementCellVM.insertRequirement(isInsertBefore: isInsertBefore, title: "Test New Req")
    }
    
    private func onAddChildAction() {}
    
    private func onRenameAction() {
        self.requirementCellVM.renameRequirement(title: "Test name")
    }
    
    private func onDeleteAction() {
        self.requirementCellVM.deleteRequirement()
    }
}

struct RequirementsListCellView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementsListCellView(requirementCellVM: RequirementCellViewModel(title: "2. About Page"), isRequirementDetailOpen: Binding.constant(false))
    }
}
