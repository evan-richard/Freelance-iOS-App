//
//  RequirementDetailSimpleSectionView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/13/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementDetailSimpleSectionView: View {
    @ObservedObject var requirementDetailVM: RequirementDetailViewModel
    @Binding var sectionValue: String
    @Binding var sectionValueId: String
    
    var sectionTitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            RequirementDetailSectionView(requirementDetailVM: requirementDetailVM, sectionValueId: $sectionValueId, sectionTitle: sectionTitle)
            Text(sectionValue)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}

struct RequirementDetailSimpleSectionView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementDetailSimpleSectionView(requirementDetailVM: RequirementDetailViewModel(requirementTitle: "2. About Page"), sectionValue: Binding.constant("Evan Richard"), sectionValueId: Binding.constant("test1"), sectionTitle: "Assignee")
    }
}
