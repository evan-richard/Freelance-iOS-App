//
//  RequirementDetailSimpleSectionView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/13/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementSimpleSectionView: View {
    @ObservedObject var requirementDetailVM: RequirementDetailViewModel
    @State private var isEditOpen: Bool = false
    
    var sectionTitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            RequirementSectionView(requirementDetailVM: requirementDetailVM, isEditOpen: $isEditOpen, sectionTitle: sectionTitle)
            Text(self.getValueForSection())
                .font(.body)
                .foregroundColor(.secondary)
        }
        .sheet(isPresented: $isEditOpen) {
            self.getViewForSection()
        }
    }
    
    private func getViewForSection() -> some View {
        switch self.sectionTitle {
            case "Assignee":
                return AnyView(AssigneeEditView(requirementDetailVM: requirementDetailVM, isEditOpen: $isEditOpen))
            case "Status":
                return AnyView(StatusEditView(requirementDetailVM: requirementDetailVM, isEditOpen: $isEditOpen))
            default:
                return AnyView(WorkInProgressView())
        }
    }
    
    private func getValueForSection() -> String {
        switch self.sectionTitle {
            case "Assignee":
                return requirementDetailVM.assignee
            case "Status":
                return requirementDetailVM.status
            default:
                return "None"
        }
    }
}

struct RequirementSimpleSectionView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementSimpleSectionView(requirementDetailVM: RequirementDetailViewModel(), sectionTitle: "Assignee")
    }
}
