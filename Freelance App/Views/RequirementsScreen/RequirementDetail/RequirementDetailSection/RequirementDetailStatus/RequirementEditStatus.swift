//
//  RequirementEditStatus.swift
//  Freelance App
//
//  Created by Evan Richard on 7/14/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementEditStatus: View {
    @ObservedObject var requirementDetailVM: RequirementDetailViewModel
    @State private var selectedLabel: String = ""
    @Binding var isEditOpen: Bool
    @Binding var sectionValueId: String
    
    private let statusOptions: [PickListItem] = [
        PickListItem(label: "To-Do", icon: "person.circle"),
        PickListItem(label: "In Progress", icon: "scribble"),
        PickListItem(label: "Done", icon: "checkmark.circle")
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Status")
                    .font(.title)
                Spacer()
                Button(action: {
                    self.isEditOpen.toggle()
                    self.requirementDetailVM.updateStatus(status: self.selectedLabel)
                }) {
                    Text("Save")
                        .fontWeight(.semibold)
                }
                .accentColor(.purple)
            }
            .padding()
            PickList(selectedLabel: self.$selectedLabel, optionList: statusOptions)
            Text("A status lets others track your progress. Maintain deadlines by updating the status of each requirement consistently and accurately.")
                .font(.caption)
                .padding(.horizontal)
            Spacer()
        }
        .padding(.top)
        .onAppear {
            self.selectedLabel = self.sectionValueId
        }
    }
}

struct RequirementEditStatus_Previews: PreviewProvider {
    static var previews: some View {
        RequirementEditStatus(requirementDetailVM: RequirementDetailViewModel(requirementTitle: "2. About Page"), isEditOpen: Binding.constant(true), sectionValueId: Binding.constant("In Progress"))
    }
}
