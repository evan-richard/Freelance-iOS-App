//
//  RequirementEditStatus.swift
//  Freelance App
//
//  Created by Evan Richard on 7/14/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct StatusEditView: View {
    @ObservedObject var requirementDetailVM: RequirementDetailViewModel
    @State private var selectedLabel: String = ""
    @Binding var isEditOpen: Bool
    
    private let statusOptions: [PickListItem] = [
        PickListItem(label: RequirementStatusConstants.TO_DO, icon: "person.circle"),
        PickListItem(label: RequirementStatusConstants.IN_PROGRESS, icon: "scribble"),
        PickListItem(label: RequirementStatusConstants.DONE, icon: "checkmark.circle")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            EditSectionHeaderView(label: "Status", action: self.onSaveAction)
                .padding(.horizontal)
            VStack(alignment: .leading) {
                PickListView(selectedLabel: self.$selectedLabel, optionList: statusOptions)
                Text("A status lets others track your progress. Maintain deadlines by updating the status of each requirement consistently and accurately.")
                    .font(.caption)
                    .padding(.horizontal)
            }
            Spacer()
        }
        .padding(.top)
        .onAppear {
            self.selectedLabel = self.requirementDetailVM.status
        }
    }
    
    private func onSaveAction() {
        self.isEditOpen.toggle()
        self.requirementDetailVM.updateStatus(status: self.selectedLabel)
    }
}

struct StatusEditView_Previews: PreviewProvider {
    static var previews: some View {
        StatusEditView(requirementDetailVM: RequirementDetailViewModel(), isEditOpen: Binding.constant(true))
    }
}
