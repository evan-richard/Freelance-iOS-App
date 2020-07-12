//
//  RequirementSimpleSectionView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/12/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementSimpleSectionView: View {
    var sectionName: String
    var sectionValue: String
    
    var body: some View {
        VStack(alignment: .leading) {
            RequirementDetailSectionView(sectionTitle: sectionName)
            Text(sectionValue)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}

struct RequirementSimpleSectionView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementSimpleSectionView(sectionName: "Assignee", sectionValue: "Evan Richard")
    }
}
