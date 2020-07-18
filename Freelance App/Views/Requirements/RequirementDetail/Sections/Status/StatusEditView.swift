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
        PickListItem(label: "To-Do", icon: "person.circle"),
        PickListItem(label: "In Progress", icon: "scribble"),
        PickListItem(label: "Done", icon: "checkmark.circle")
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            EditSectionHeaderView(label: "Status", action: {
                self.isEditOpen.toggle()
                self.requirementDetailVM.updateStatus(status: self.selectedLabel)
            })
            PickListView(selectedLabel: self.$selectedLabel, optionList: statusOptions)
            Text("A status lets others track your progress. Maintain deadlines by updating the status of each requirement consistently and accurately.")
                .font(.caption)
                .padding(.horizontal)
            Spacer()
        }
        .padding(.top)
        .onAppear {
            self.selectedLabel = self.requirementDetailVM.status
        }
    }
}

struct StatusEditView_Previews: PreviewProvider {
    static var previews: some View {
        StatusEditView(requirementDetailVM: RequirementDetailViewModel(requirementTitle: "2. About Page"), isEditOpen: Binding.constant(true))
    }
}
