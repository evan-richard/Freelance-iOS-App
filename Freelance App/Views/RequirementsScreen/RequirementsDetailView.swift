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
    
    init(requirementTitle: String) {
        requirementDetailVM = RequirementDetailViewModel(requirementTitle: requirementTitle)
    }
    
    var body: some View {
        Text(requirementDetailVM.title)
    }
}

struct RequirementsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementsDetailView(requirementTitle: "2. About Page")
    }
}
