//
//  RequirementDetailTitleBar.swift
//  Freelance App
//
//  Created by Evan Richard on 7/12/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementDetailTitleBarView: View {
    @Binding var isRequirementDetailViewOpen: Bool
    
    var requirementDetailTitleBar: String
    
    var body: some View {
        HStack(alignment: .center) {
            Text(requirementDetailTitleBar)
                .font(.title)
            Spacer()
            Button(action: self.closeRequirementDetailAction) {
                ReusableTextButtonView(label: "Done")
            }
            .accentColor(ThemeConstants.ACCENT_COLOR)
        }
    }
    
    private func closeRequirementDetailAction() {
        self.isRequirementDetailViewOpen.toggle()
    }
}

struct RequirementDetailTitleBarView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementDetailTitleBarView(isRequirementDetailViewOpen: Binding.constant(true), requirementDetailTitleBar: "2. About Page")
    }
}
