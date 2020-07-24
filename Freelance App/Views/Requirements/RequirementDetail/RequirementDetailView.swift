//
//  RequirementsDetailView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/9/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementDetailView: View {
    @ObservedObject private var requirementDetailVM: RequirementDetailViewModel = RequirementDetailViewModel()
    @Binding var isRequirementDetailViewOpen: Bool
    
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
        RequirementDetailView(isRequirementDetailViewOpen: Binding.constant(false))
    }
}
