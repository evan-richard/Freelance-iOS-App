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
    @ObservedObject var messageListVM: MessageListViewModel = MessageListViewModel()
    @Binding var isRequirementDetailViewOpen: Bool
    
    var body: some View {
            VStack(alignment: .leading, spacing: 40) {
                RequirementDetailTitleBarView(isRequirementDetailViewOpen: $isRequirementDetailViewOpen ,requirementDetailTitleBar: requirementDetailVM.titleWithPrefix)
                    .padding(.horizontal)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 40) {
                        RequirementSimpleSectionView(requirementDetailVM: requirementDetailVM, sectionTitle: "Assignee")
                            .padding(.horizontal)
                        
                        RequirementSimpleSectionView(requirementDetailVM: requirementDetailVM, sectionTitle: "Estimated Sprint")
                            .padding(.horizontal)
                        
                        RequirementSimpleSectionView(requirementDetailVM: requirementDetailVM, sectionTitle: "Status")
                            .padding(.horizontal)
                        
                        FeaturesView(requirementDetailVM: requirementDetailVM)
                            .padding(.horizontal)
                        
                        CommentsView(requirementDetailVM: requirementDetailVM, messageListVM: messageListVM)
                    }
                }
                
                RequirementDetailFooterView(messageListVM: messageListVM)
            }
            .padding(.vertical)
            .padding(.top)
    }
}

struct RequirementDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementDetailView(isRequirementDetailViewOpen: Binding.constant(false))
    }
}
