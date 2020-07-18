//
//  RequirementsDetailView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/9/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementDetailView: View {
    @ObservedObject private var requirementDetailVM: RequirementDetailViewModel
    @Binding var isRequirementDetailViewOpen: Bool
    
    init(requirementTitle: String, isRequirementDetailViewOpen: Binding<Bool>) {
        self._isRequirementDetailViewOpen = isRequirementDetailViewOpen
        requirementDetailVM = RequirementDetailViewModel(requirementTitle: requirementTitle)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                RequirementDetailTitleBarView(isRequirementDetailViewOpen: $isRequirementDetailViewOpen ,requirementDetailTitleBar: requirementDetailVM.titleWithPrefix)
                
                RequirementSimpleSectionView(requirementDetailVM: requirementDetailVM, sectionTitle: "Assignee")
                
                RequirementSimpleSectionView(requirementDetailVM: requirementDetailVM, sectionTitle: "Estimated Sprint")
                
                RequirementSimpleSectionView(requirementDetailVM: requirementDetailVM, sectionTitle: "Status")
                
                FeaturesView(requirementDetailVM: requirementDetailVM)
                
                Spacer()
            }
            .padding()
            .padding(.top)
        }
    }
}

struct RequirementDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementDetailView(requirementTitle: "2. About Page", isRequirementDetailViewOpen: Binding.constant(false))
    }
}
