//
//  RequirementsDetailView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/9/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementsDetailView: View {
    @ObservedObject private var requirementDetailVM: RequirementDetailViewModel
    
    @Binding var isRequirementDetailViewOpen: Bool
    
    init(requirementTitle: String, isRequirementDetailViewOpen: Binding<Bool>) {
        self._isRequirementDetailViewOpen = isRequirementDetailViewOpen
        requirementDetailVM = RequirementDetailViewModel(requirementTitle: requirementTitle)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            RequirementDetailTitleBar(isRequirementDetailViewOpen: $isRequirementDetailViewOpen ,requirementDetailTitleBar: requirementDetailVM.titleWithPrefix)
            RequirementDetailSimpleSectionView(sectionTitle: "Assignee", sectionValue: $requirementDetailVM.assignee, sectionValueId: $requirementDetailVM.assigneeId)
            RequirementDetailSimpleSectionView(sectionTitle: "Estimated Sprint", sectionValue: Binding.constant("Sprint 3"), sectionValueId: Binding.constant("Sprint 3"))
            RequirementDetailSimpleSectionView(sectionTitle: "Status", sectionValue: $requirementDetailVM.status, sectionValueId: $requirementDetailVM.status)
            Spacer()
        }
        .padding()
    }
}

struct RequirementsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementsDetailView(requirementTitle: "2. About Page", isRequirementDetailViewOpen: Binding.constant(false))
    }
}
