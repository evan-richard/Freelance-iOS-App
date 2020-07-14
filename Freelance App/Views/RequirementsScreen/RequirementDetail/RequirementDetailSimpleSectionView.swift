//
//  RequirementDetailSimpleSectionView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/13/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementDetailSimpleSectionView: View {
    var sectionTitle: String
    
    @Binding var sectionValue: String
    @Binding var sectionValueId: String
    
    var body: some View {
        VStack(alignment: .leading) {
            RequirementDetailSectionView(sectionTitle: sectionTitle, sectionValueId: $sectionValueId)
            Text(sectionValue)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}

struct RequirementDetailSimpleSectionView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementDetailSimpleSectionView(sectionTitle: "Assignee", sectionValue: Binding.constant("Evan Richard"), sectionValueId: Binding.constant("test1"))
    }
}
