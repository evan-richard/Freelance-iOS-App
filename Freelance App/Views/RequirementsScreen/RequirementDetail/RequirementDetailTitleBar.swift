//
//  RequirementDetailTitleBar.swift
//  Freelance App
//
//  Created by Evan Richard on 7/12/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementDetailTitleBar: View {
    @Binding var isRequirementDetailViewOpen: Bool
    
    var requirementDetailTitleBar: String
    
    var body: some View {
        HStack(alignment: .center) {
            Text(requirementDetailTitleBar)
                .font(.title)
            Spacer()
            Button(action: {
                self.isRequirementDetailViewOpen.toggle()
            }) {
                Text("Done")
                    .fontWeight(.semibold)
            }
            .accentColor(.purple)
        }
    }
}

struct RequirementDetailTitleBar_Previews: PreviewProvider {
    static var previews: some View {
        RequirementDetailTitleBar(isRequirementDetailViewOpen: Binding.constant(true), requirementDetailTitleBar: "2. About Page")
    }
}