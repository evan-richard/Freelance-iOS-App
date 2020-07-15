//
//  RequirementDetailSectionView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/12/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementDetailSectionView: View {
    @ObservedObject var requirementDetailVM: RequirementDetailViewModel
    @State private var isEditOpen: Bool = false
    @Binding var sectionValueId: String
    
    var sectionTitle: String
    
    var body: some View {
        VStack {
            HStack {
                Text(sectionTitle)
                Spacer()
                Button(action: {
                    self.isEditOpen.toggle()
                }) {
                    Text("Edit")
                }
                .accentColor(.purple)
            }
            Divider()
        }
        .sheet(isPresented: $isEditOpen) {
            self.getViewForSection()
        }
        .padding(.top)
    }
    
    private func getViewForSection() -> some View {
        switch self.sectionTitle {
            case "Assignee":
                return AnyView(RequirementEditAssignee(requirementDetailVM: requirementDetailVM, isEditOpen: $isEditOpen, sectionValueId: $sectionValueId))
            case "Status":
                return AnyView(RequirementEditStatus(requirementDetailVM: requirementDetailVM, isEditOpen: $isEditOpen, sectionValueId: $sectionValueId))
            default:
                return AnyView(WorkInProgressView())
        }
    }
}

struct RequirementDetailSectionView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementDetailSectionView(requirementDetailVM: RequirementDetailViewModel(requirementTitle: "2. About Page"), sectionValueId: Binding.constant("test1"), sectionTitle: "Assignee")
    }
}
